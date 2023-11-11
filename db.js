const mysql = require('mysql2/promise');
const db = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    connectionLimit: 10,
    idleTimeout: 10000,
    connectTimeout: 10000,
});

module.exports = db;