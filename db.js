const mysql = require("mysql2");
const db = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  pool: {
    handleDisconnect: ()=>{
        return db;
    },
    max: 10,
    min: 0,
    acquire: 30000,
    idle: 10000,
  },
  port: 3306,
  debug: true
});

module.exports = db;
