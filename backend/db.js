const { Pool } = require("pg");

// ❗ Check DATABASE_URL hai ya nahi
if (!process.env.DATABASE_URL) {
  console.error("❌ DATABASE_URL missing");
  process.exit(1);
}

const isProduction = process.env.NODE_ENV === "production";

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,

  // ✅ Render pe SSL ON
  ssl: isProduction
    ? { rejectUnauthorized: false }
    : false,

  max: 20,
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 5000,
});

// ✅ Connection log
pool.on("connect", () => {
  console.log("✅ PostgreSQL Connected");
});

// ❌ Error log
pool.on("error", (err) => {
  console.error("❌ Unexpected DB Error:", err.message);
});

// 🔥 Startup test
(async () => {
  try {
    const client = await pool.connect();
    console.log("🚀 DB connection successful");
    client.release();
  } catch (err) {
    console.error("❌ DB connection failed:", err.message);
  }
})();

module.exports = pool;