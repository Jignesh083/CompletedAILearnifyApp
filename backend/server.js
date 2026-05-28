    require("dotenv").config();
    const express = require("express");
    const cors = require("cors");
const bcrypt = require('bcryptjs');
    const Razorpay = require("razorpay");
    const http = require("http");
    const socketIo = require("socket.io");
    const app = express();
    app.use(cors());
    app.use(express.json());
const pool = require("./db");


    /* ================= AUTH ================= */

    app.post("/auth/register", async (req,res)=>{
    try{
      const {name,email,password} = req.body;
      const hash = await bcrypt.hash(password,10);

      const r = await pool.query(
      "INSERT INTO users(name,email,password) VALUES($1,$2,$3) RETURNING id",
      [name,email,hash]
      );

      res.json({success:true,user_id:r.rows[0].id});

    }catch(e){
      console.log(e);
      res.status(500).json({success:false});
    }
    });

    app.post("/auth/login", async (req,res)=>{
    try{
      const {email,password} = req.body;

      const u = await pool.query(
      "SELECT * FROM users WHERE email=$1",
      [email]
      );

      if(!u.rows.length)
      return res.status(401).json({error:"User not found"});

      const ok = await bcrypt.compare(password,u.rows[0].password);

      if(!ok)
      return res.status(401).json({error:"Invalid password"});

      res.json({
      success:true,
      user_id:u.rows[0].id,
      name:u.rows[0].name
      });

    }catch(e){
      console.log(e);
      res.status(500).json({success:false});
    }
    });

    /* ================= QUIZ LOAD ================= */

  app.get("/quiz/:topicKey", async (req,res)=>{
  try{
    const {topicKey} = req.params;
    const {page=1,limit=20} = req.query;

    const offset = (page-1)*limit;

    // 🔥 STEP 1: topic_id nikaalo
    const topicRes = await pool.query(
      "SELECT id FROM topics WHERE topic_key = $1",
      [topicKey]
    );

    if(topicRes.rows.length === 0){
      return res.json([]);
    }

    const topicId = topicRes.rows[0].id;

    // 🔥 STEP 2: questions fetch karo (NO JOIN WITH topics)
    const data = await pool.query(`
      SELECT 
        q.id,
        q.question,
        json_agg(
          json_build_object(
            'id', o.id,
            'text', o.option_text,
            'is_correct', o.is_correct
          )
          ORDER BY o.id
        ) as options
      FROM questions q
      JOIN options o ON o.question_id = q.id
      WHERE q.topic_id = $1
      GROUP BY q.id
      ORDER BY q.id
      LIMIT $2 OFFSET $3
    `,[topicId, limit, offset]);

res.json({
  success: true,
  data: data.rows,
  error: null
});
  }catch(e){
    console.log("QUIZ ERROR:", e);
    res.status(500).json([]);
  }
});



app.get("/check-db", async (req,res)=>{
  try{
    const topics = await pool.query("SELECT * FROM topics LIMIT 5");
    res.json(topics.rows);
  }catch(e){
    console.log(e);
    res.json({error:"DB error"});
  }
});

    /* ================= ATTEMPT ================= */

  app.post("/quiz/start", async (req, res) => {
  try {
    const { user_id, topic_key } = req.body;

    // 🔍 Debug logs
    console.log("START ATTEMPT REQUEST:", req.body);

    // ❌ Validation
    if (!user_id || !topic_key) {
      return res.status(400).json({
        success: false,
        error: "Missing user_id or topic_key",
      });
    }

    // 🔍 Get topic
    const topic = await pool.query(
      "SELECT id FROM topics WHERE topic_key=$1",
      [topic_key]
    );

    if (!topic.rows.length) {
      console.log("❌ Invalid topic:", topic_key);
      return res.status(400).json({
        success: false,
        error: "Invalid topic",
      });
    }

    const topicId = topic.rows[0].id;

    // 🧠 Insert attempt
    const result = await pool.query(
      `INSERT INTO attempts(user_id, topic_id, status, quiz_type)
       VALUES($1, $2, 'started', 'topic')
       RETURNING id`,
[String(user_id), topicId]
    );

    const attemptId = result.rows[0].id;

    console.log("✅ ATTEMPT CREATED:", attemptId);

    // ✅ Proper response
    return res.json({
      success: true,
      attempt_id: attemptId,
    });

  } catch (e) {
console.log("❌ START ATTEMPT ERROR FULL:", e.message, e.stack);
    return res.status(500).json({
      success: false,
      error: "Server error",
    });
  }
});

    app.post("/quiz/submit-attempt", async (req,res)=>{
      console.log("SUBMIT ROUTE HIT");
    console.log(req.body);
    try{
      const {attempt_id,answers} = req.body;

      let score = 0;

      for(const a of answers){

      const r = await pool.query(
        "SELECT is_correct FROM options WHERE id=$1",
        [a.option_id]
      );

      const correct = r.rows[0]?.is_correct;

      if(correct) score++;

      await pool.query(
        `INSERT INTO attempt_responses
        (attempt_id,question_id,selected_option_id,is_correct)
        VALUES($1,$2,$3,$4)`,
        [attempt_id,a.question_id,a.option_id,correct]
      );

      }

      await pool.query(
      `UPDATE attempts
        SET score=$1,status='submitted',submitted_at=NOW()
        WHERE id=$2`,
      [score,attempt_id]
      );

      res.json({success:true,score});

    }catch(e){
      console.log(e);
      res.status(500).json({success:false});
    }
    });

    /* ================= DAILY QUIZ ================= */

    app.get("/daily-quiz/:subject", async (req,res)=>{
    try{
      const prefix = req.params.subject+"%";

      const data = await pool.query(`
      SELECT 
        q.id,
        q.question,
        json_agg(
        json_build_object(
          'id',o.id,
          'text',o.option_text
        )
        ) as options
      FROM questions q
      JOIN options o ON o.question_id=q.id
      JOIN topics t ON t.id=q.topic_id
      WHERE t.topic_key LIKE $1
      GROUP BY q.id
      ORDER BY RANDOM()
      LIMIT 20
      `,[prefix]);

      res.json(data.rows);

    }catch(e){
      res.status(500).json([]);
    }
    });


    /* ================= PURCHASE ================= */
app.get("/purchase/check/:topicId/:userId", async (req,res)=>{
  try{

    const { topicId, userId } = req.params;

    const q = await pool.query(
      `SELECT 1 FROM purchases
       WHERE user_id = $1
       AND topic_id = $2
       AND (expiry_date IS NULL OR expiry_date > NOW())
       LIMIT 1`,
      [String(userId), Number(topicId)]
    );

    res.json({
      unlocked: q.rows.length > 0
    });

  }catch(e){
    console.log("purchase check error", e);
    res.json({ unlocked:false });
  }
});

    /* ================= LEADERBOARD ================= */

    app.get("/leaderboard", async (req,res)=>{
    try{
      const d = await pool.query(`
      SELECT 
        u.id,
        u.name,
        SUM(a.score) as total_score,
        COUNT(a.id) as attempts
      FROM attempts a
      JOIN users u ON u.id=a.user_id
      GROUP BY u.id,u.name
      ORDER BY total_score DESC
      LIMIT 20
      `);

      res.json(d.rows);

    }catch(e){
      res.status(500).json([]);
    }
    });

    /* ================= PAYMENT ================= */

const razorpay = new Razorpay({
  key_id: process.env.RAZORPAY_KEY,
  key_secret: process.env.RAZORPAY_SECRET
});

    app.post("/payment/create-order", async (req,res)=>{
      try{
        const order = await razorpay.orders.create({
          amount: 49900,     // ₹999
          currency: "INR",
          receipt: "rcpt_"+Date.now()
        });
        console.log("ORDER:", order);
        console.log("AMOUNT TEST:", 49900);

    res.json(order);

  }catch(e){
    console.log("ORDER ERROR", e);
    res.status(500).json({error:true});
  }
  });


app.post("/payment/verify", async (req, res) => {
  try {

    console.log("VERIFY BODY:", req.body);

    const {
      razorpay_payment_id,
      user_id,
      topic_id,
      email: incomingEmail   // 🔥 rename to avoid conflict
    } = req.body || {};

    // ✅ VALIDATION
    if (!user_id || !topic_id || !razorpay_payment_id) {
      return res.status(400).json({
        success: false,
        error: "Missing fields"
      });
    }

    let finalEmail = incomingEmail || null;

    // 🔥 OPTIONAL fallback (only if frontend didn't send email)
    if (!finalEmail) {
      try {
        const user = await pool.query(
          "SELECT email FROM users WHERE id=$1",
          [user_id]
        );

        if (user.rows.length > 0) {
          finalEmail = user.rows[0].email;
        }
      } catch (err) {
        console.log("USER FETCH ERROR:", err);
      }
    }

    console.log("FINAL EMAIL:", finalEmail);

    // ✅ INSERT / UPDATE PURCHASE
    await pool.query(
      `INSERT INTO purchases
       (user_id, topic_id, payment_id, email, expiry_date)
       VALUES($1,$2,$3,$4,NOW() + INTERVAL '365 days')
       ON CONFLICT (user_id, topic_id)
       DO UPDATE SET 
         payment_id = EXCLUDED.payment_id,
         expiry_date = NOW() + INTERVAL '365 days',
         email = EXCLUDED.email`,   // 🔥 important
      [
        user_id,
        Number(topic_id),
        razorpay_payment_id,
        finalEmail
      ]
    );

    console.log("PURCHASE SAVED SUCCESS");

    return res.json({
      success: true
    });

  } catch (e) {

    console.log("VERIFY ERROR FULL:", e);

    return res.status(500).json({
      success: false,
      error: e.message || "Server error"
    });

  }
});

    /* ================= SOCKET ================= */

    const server = http.createServer(app);
    const io = socketIo(server,{cors:{origin:"*"}});

    // io.on("connection",(socket)=>{
    // setInterval(async ()=>{
    //   const d = await pool.query(`
    //   SELECT u.name,SUM(a.score) as score
    //   FROM attempts a
    //   JOIN users u ON u.id=a.user_id
    //   GROUP BY u.name
    //   ORDER BY score DESC
    //   LIMIT 10
    //   `);
    //   socket.emit("leaderboard",d.rows);
    // },5000);
    // });


    io.on("connection",(socket)=>{

setInterval(async ()=>{

try{

  const d = await pool.query(`
    SELECT 
      u.name,
      SUM(a.score) as score

    FROM attempts a

    JOIN users u
    ON u.id = a.user_id::integer

    GROUP BY u.name

    ORDER BY score DESC

    LIMIT 10
  `);

  socket.emit("leaderboard", d.rows);

}catch(e){

  console.log("SOCKET ERROR:", e.message);

}

},5000);

});

const PORT = process.env.PORT || 3000;

server.listen(PORT, () => {
  console.log("Server running on port " + PORT);
});

app.get("/user/:id", async (req,res)=>{
  try{

    const { id } = req.params;

    const user = await pool.query(
      `SELECT name FROM users WHERE id=$1`,
      [id]
    );

    const stats = await pool.query(
      `SELECT 
        COUNT(*) as completed_quizzes,
        COALESCE(SUM(score),0) as total_score
       FROM attempts
       WHERE user_id=$1 AND status='submitted'`,
      [id]
    );

    res.json({
      name: user.rows[0]?.name || "Student",
      completedQuizzes: Number(stats.rows[0].completed_quizzes),
      totalScore: Number(stats.rows[0].total_score),
      appVersion: "1.0.0"
    });

  }catch(e){
    console.log("USER FETCH ERROR:", e);
    res.status(500).json({});
  }
});

app.get("/purchase/my/:userId", async (req, res) => {
  try {
    const { userId } = req.params;

    const data = await pool.query(
      `SELECT topic_id FROM purchases WHERE user_id = $1`,
      [userId]
    );

    res.json({
      success: true,
      courses: data.rows
    });

  } catch (e) {
    console.log("MY PURCHASE ERROR:", e);
    res.status(500).json({ success: false });
  }
});



const multer = require("multer");
const mammoth = require("mammoth");

const upload = multer({ dest: "uploads/" });

// 🔥 ADD THIS ROUTE
app.post("/admin/upload-quiz", upload.single("file"), async (req, res) => {
  try {
    const bundleKey = req.body.bundleKey;

    const result = await mammoth.extractRawText({
      path: req.file.path
    });

    const text = result.value;

    const { splitTopics, parseQuestions, generateTopicKey } = require("./scripts/parser");
const subject = await pool.query(
  `
  SELECT id
  FROM subjects
  WHERE subject_key=$1
  `,
  [bundleKey]
);

if(!subject.rows.length){

  return res.json({
    message:"Subject not found ❌"
  });

}

const subjectId = subject.rows[0].id;
    const topics = splitTopics(text);

    for (const t of topics) {

      const topicKey = generateTopicKey(t.topicName);

      let topic = await pool.query(
        "SELECT id FROM topics WHERE topic_key = $1",
        [topicKey]
      );

      let topicId;

      if (!topic.rows.length) {
        const newTopic = await pool.query(
  `
  INSERT INTO topics (
    topic_key,
    bundle_key,
    subject_id
  )
  VALUES ($1,$2,$3)
  RETURNING id
  `,
  [topicKey, bundleKey, subjectId]
);
        topicId = newTopic.rows[0].id;
      } else {
        topicId = topic.rows[0].id;
      }

      const questions = parseQuestions(t.content);

      for (const q of questions) {

        const qRes = await pool.query(
          "INSERT INTO questions (question, topic_id) VALUES ($1,$2) RETURNING id",
          [q.question, topicId]
        );

        const qId = qRes.rows[0].id;

        for (const opt of q.options) {
          await pool.query(
            "INSERT INTO options (question_id, option_text, is_correct, explanation) VALUES ($1,$2,$3,$4)",
            [qId, opt.text, opt.isCorrect, q.explanation]
          );
        }
      }
    }

    res.json({ message: "Upload success 🚀" });

  } catch (e) {
    console.log(e);
    res.json({ message: "Upload failed ❌" });
  }
});

/* ================= ADMIN STATS ================= */

app.get("/admin/stats", async(req,res)=>{

  try{

    const users = await pool.query(
      "SELECT COUNT(*) FROM users"
    );

    const attempts = await pool.query(
      "SELECT COUNT(*) FROM attempts"
    );

    const avg = await pool.query(
      "SELECT AVG(score) FROM attempts"
    );

    res.json({
      total_users: users.rows[0].count,
      total_attempts: attempts.rows[0].count,
      avg_score: avg.rows[0].avg || 0
    });

  }catch(e){

    console.log(e);

    res.status(500).json({
      error:"server error"
    });

  }

});


/* ================= DAILY USERS ================= */

app.get("/admin/daily-users", async(req,res)=>{

  try{

    const data = await pool.query(`
      SELECT
      DATE(created_at) as day,
      COUNT(*) as users
      FROM users
      GROUP BY day
      ORDER BY day ASC
    `);

    res.json(data.rows);

  }catch(e){

    console.log(e);

    res.status(500).json({
      error:"server error"
    });

  }

});


/* ================= TOPIC ACCURACY ================= */

app.get("/admin/topic-accuracy", async(req,res)=>{

  try{

    const data = await pool.query(`
      SELECT
      t.topic_key,

      ROUND(
        AVG(
          CASE
          WHEN ar.is_correct=true THEN 100
          ELSE 0
          END
        ),2
      ) as accuracy

      FROM attempt_responses ar

      JOIN questions q
      ON q.id=ar.question_id

      JOIN topics t
      ON t.id=q.topic_id

      GROUP BY t.topic_key

      ORDER BY accuracy ASC

      LIMIT 10
    `);

    res.json(data.rows);

  }catch(e){

    console.log(e);

    res.status(500).json({
      error:"server error"
    });

  }

});



app.get("/subjects", async (req, res) => {

  try {

    const result = await pool.query(`
      SELECT *
      FROM subjects
      ORDER BY id ASC
    `);

    res.json(result.rows);

  } catch (e) {

    console.log(e);

    res.status(500).json({
      error: "server error"
    });

  }

});

app.get("/ping", (req, res) => {
  res.status(200).json({
    success: true,
    message: "Server Active",
    time: new Date(),
  });
});

app.use((err, req, res, next) => {
  console.error("GLOBAL ERROR:", err);

  res.status(500).json({
    success: false,
    data: null,
    error: "Internal server error"
  });
});