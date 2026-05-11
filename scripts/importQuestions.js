const fs = require("fs");
const path = require("path");
const { Pool } = require("pg");

const pool = new Pool({
  user: "postgres",
  host: "localhost",
  database: "ailearnify",
  password: "ushakumari@aicore",
  port: 5432,
});

const baseFolder = path.join(__dirname, "../app/data/questions");

async function importTopic(folder, topicKey) {
  const client = await pool.connect();

  try {
    await client.query("BEGIN");

    // topic get or skip
    const topicRes = await client.query(
      `INSERT INTO topics(topic_key)
       VALUES($1)
       ON CONFLICT(topic_key)
       DO UPDATE SET topic_key = EXCLUDED.topic_key
       RETURNING id`,
      [topicKey]
    );

    const topicId = topicRes.rows[0].id;

    const filePath = path.join(folder, `${topicKey}.json`);
    if (!fs.existsSync(filePath)) return;

    const raw = fs.readFileSync(filePath, "utf8");
    const clean = raw.replace(/^\uFEFF/, "");
    const json = JSON.parse(clean);

    // SUPPORT BOTH STRUCTURES
    const questions = json.questions ? json.questions : json;

    console.log(`🚀 Importing Topic: ${topicKey}`);
    console.log(`❓ Total Questions: ${questions.length}`);

    for (const q of questions) {

      // duplicate question skip
      const dup = await client.query(
        `SELECT id FROM questions
         WHERE topic_id=$1 AND question_text=$2`,
        [topicId, q.question]
      );

      if (dup.rows.length) {
        console.log("⚠ Duplicate skipped");
        continue;
      }

      const qRes = await client.query(
        `INSERT INTO questions(topic_id, question_text)
         VALUES($1,$2) RETURNING id`,
        [topicId, q.question]
      );

      const questionId = qRes.rows[0].id;

      // batch options insert
      const values = [];
      const params = [];

      q.options.forEach((opt, i) => {
        const base = i * 3;
        values.push(`($${base + 1}, $${base + 2}, $${base + 3})`);
        params.push(questionId, opt, i === q.answer);
      });

      await client.query(
        `INSERT INTO options(question_id, option_text, is_correct)
         VALUES ${values.join(",")}`,
        params
      );
    }

    await client.query("COMMIT");

    console.log(`✅ Topic Imported: ${topicKey}\n`);
  } catch (err) {
    await client.query("ROLLBACK");
    console.error("❌ Import Failed:", err);
  } finally {
    client.release();
  }
}

async function run() {
  const folders = fs.readdirSync(baseFolder);

  for (const folder of folders) {
    const folderPath = path.join(baseFolder, folder);
    const topicFiles = fs.readdirSync(folderPath);

    for (const file of topicFiles) {
      if (!file.endsWith(".json")) continue;

      const topicKey = file.replace(".json", "");
      await importTopic(folderPath, topicKey);
    }
  }

  console.log("🎉 ALL IMPORT FINISHED");
  process.exit();
}

run();