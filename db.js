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
    idleTimeout: 10000,
    maxIdle: 10000,
    debug: true,
    maxPreparedStatements: 100,
});

module.exports = db;