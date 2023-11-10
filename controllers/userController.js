const db = require("../db");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

const create = async (req, res) => {
  try {
    const { nom, tel, email, password, rpps, role } = req.body;

    //hashage du mot de passe
    const hashedPassword = await bcrypt.hash(password, 10);

    //insertion dans la base de données
    const [rows, fields] = await (
      await db
    ).query(
      "INSERT INTO users (nom, tel, email, password, rpps, role, is_verified) VALUES (?, ?, ?, ?, ?, ?, 1)",
      [nom, tel, email, hashedPassword, rpps, role]
    );

    //envoi de la réponse
    res.send({
      message: "Utilisateur créé avec succès",
    });
  } catch (err) {
    console.log(err);
    res.status(500).send({
      error: "Erreur lors de la création de l'utilisateur",
    });
  }
};

const updateOne = async (req, res) => {
  try {
    const { id, nom, tel, rpps, role } = req.body;

    const [rows, fields] = await (
      await db
    ).query(
      "UPDATE users SET nom = ?, tel = ?, rpps = ?, role = ? WHERE id = ?",
      [nom, tel, rpps, role, id]
    );

    // Envoi de la réponse
    res.send({
      message: "Utilisateur modifié avec succès",
    });
  } catch (err) {
    console.log(err);
    res.status(500).send({
      error: "Erreur lors de la modification de l'utilisateur",
    });
  }
};

const deleteOne = async (req, res) => {
  try {
    const id = req.params.id;

    // Suppression de l'utilisateur
    const [rows, fields] = await (
      await db
    ).query("DELETE FROM users WHERE id = ?", [id]);

    // Envoi de la réponse
    res.send({
      message: "Utilisateur supprimé avec succès",
    });
  } catch (err) {
    console.log(err);
    res.status(500).send({
      error: "Erreur lors de la suppression de l'utilisateur",
    });
  }
};

const signup = async (req, res) => {
  try {
    const { nom, tel, adresse, email, password, rpps } = req.body;
    console.log(req.body)
    const hashedPassword = await bcrypt.hash(password, 10);
    
    const [rows, fields] = await (
      await db
    ).query(
      "INSERT INTO users (nom, tel, adresse, email, password, rpps, role, is_verified) VALUES (?, ?, ?, ?, ?, ?, 'Medecin', 0)",
      [nom, tel, adresse, email, hashedPassword, rpps]
    );
    return res.send({
      message: "Compte créé, en attente de vérification",
    });
  } catch (err) {
    console.log(err);
    if(err.errno === 1062){
      return res.status(500).send({
        error: "L'email existe déjà",
      });
    }
    return res.status(500).send({
      error: "Erreur lors de la création de l'utilisateur",
    });
  }
};

const login = async (req, res) => {
  const role = req.params.role;
  try {
    const { email, password } = req.body;

    // Vérification de l'utilisateur
    const [rows, fields] = await (
      await db
    ).query("SELECT * FROM users WHERE email = ?", [email]);
    if (rows.length === 0) {
      return res.status(401).send({
        error: "L'utilisateur n'existe pas",
      });
    }
    const user = rows[0];

    // Vérification du rôle
    if (user.role !== role) {
      return res.status(401).send({
        error: "L'utilisateur n'a pas le bon rôle",
      });
    }
    if (role === "medecin" && user.is_verified === 0) {
      return res.status(401).send({
        error: "L'utilisateur n'est pas encore vérifié",
      });
    }

    // Vérification du mot de passe
    const match = await bcrypt.compare(password, user.password);
    if (!match) {
      return res.status(401).send({
        error: "Mot de passe incorrect",
      });
    }
    delete user.password;

    // Création du token
    const token = jwt.sign(
      { id: user.id, date: Date.now() },
      process.env.JWT_SECRET
    );
    const [data, error] = await (
      await db
    ).query("INSERT INTO tokens (id_user, token) VALUES (?, ?)", [
      user.id,
      token,
    ]);
    if (error) throw new Error(error);

    // Envoi de la réponse
    res.send({
      message: "Utilisateur connecté avec succès",
      user,
      token,
    });
  } catch (err) {
    console.log(err);
    res.status(500).send({
      error: "Erreur lors de la connexion de l'utilisateur",
    });
  }
};

const getAll = async (req, res) => {
  try {
    // Récupération des utilisateurs
    const [rows, fields] = await (await db).query("SELECT * FROM users");
    const users = rows.map((user) => {
      delete user.password;
      return user;
    });

    // Envoi de la réponse
    res.send({
      users,
    });
  } catch (err) {
    console.log(err);
    res.status(500).send({
      error: "Erreur lors de la récupération des utilisateurs",
    });
  }
};

const verifyMedecin = async (req, res) => {
  try {
    const { id } = req.body;
    const [rows, fields] = await (
      await db
    ).query("UPDATE users SET is_verified = 1 WHERE id = ?", [id]);
    res.send({
      message: "Utilisateur vérifié avec succès",
    });
  } catch (err) {
    console.log(err);
    res.status(500).send({
      error: "Erreur lors de la vérification de l'utilisateur",
    });
  }
};

const checkConnectedUser = async (req, res) => {
  const role = req.params.role;
  // Récupération du token
  const token = req.header("Authorization")?.split(" ")[1];
  try {
    // Récupération de l'utilisateur connecté
    const [rows, fields] = await (
      await db
    ).query(
      "Select * From users, tokens Where users.id = tokens.id_user AND tokens.token = ?",
      [token]
    );
    if (rows.length === 0) {
      return res.status(401).send({
        error: "Utilisateur non connecté",
      });
    }

    // Vérification du rôle
    if (rows[0].role !== role) {
      return res.status(401).send({
        error: "L'utilisateur n'a pas le bon rôle",
      });
    }

    const user = rows[0];
    delete user.password;

    // Envoi de la réponse
    res.send({
      user,
    });
  } catch (err) {
    console.log(err);
    res.status(500).send({
      error: "Erreur lors de la récupération de l'utilisateur connecté",
    });
  }
};

const logout = async (req, res) => {
  // Récupération du token
  const token = req.header("Authorization")?.split(" ")[1];
  try {
    // Suppression du token
    const [rows, fields] = await (
      await db
    ).query("DELETE FROM tokens WHERE token = ?", [token]);

    // Envoi de la réponse
    res.send({
      message: "Utilisateur déconnecté avec succès",
    });
  } catch (err) {
    console.log(err);
    res.status(500).send({
      error: "Erreur lors de la déconnexion de l'utilisateur",
    });
  }
};

module.exports = {
  create,
  updateOne,
  deleteOne,
  verifyMedecin,
  signup,
  login,
  getAll,
  checkConnectedUser,
  logout,
};
