const mysql = require('mysql2/promise');
const db = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    connectTimeout: 10000,
    waitForConnections: true,
    connectionLimit: 100,
    multipleStatements: true,
    debug: true,
});

module.exports = db;