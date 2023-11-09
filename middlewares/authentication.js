const db = require("../db");

const checkToken = (role) => async (req, res, next) => {
  try {
    if (!req.headers.authorization) {
      return res.status(401).json({
        error: "Token invalide",
      });
    }

    const authorization = req.headers.authorization.split(" ");
    const token = authorization[1];

    const [results] = await (await db).query("SELECT * FROM users, tokens WHERE users.id = tokens.id_user AND token = ?", [
      token,
    ]);

    if (!results.length) {
      return res.status(401).json({
        error: "Token invalide",
      });
    }

    if(!role.includes(results[0].role)) {
      return res.status(401).json({
        error: "Vous n'êtes pas autorisé à accéder à cette ressource",
      });
    }

    next();
  } catch (err) {
    console.log(err);
    res.sendStatus(500);
  }
};

module.exports = checkToken;