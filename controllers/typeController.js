const db = require("../db");

const create = async (req, res) => {
  try {
    const { nom } = req.body;

    //insertion dans la base de données
    const [rows, fields] = await (
      await db
    ).query("INSERT INTO types (nom_type) VALUES (?)", [nom]);

    //envoi de la réponse
    res.send({
      message: "Type créé avec succès",
    });
  } catch (err) {
    console.log(err);
    res.status(500).send({
      error: "Erreur lors de la création du type",
    });
  }
};

const updateOne = async (req, res) => {
  try {
    const { id, nom } = req.body;

    const [rows, fields] = await (
      await db
    ).query("UPDATE types SET nom_type = ? WHERE id = ?", [nom, id]);

    // Envoi de la réponse
    res.send({
      message: "Type modifié avec succès",
    });
  } catch (err) {
    console.log(err);
    res.status(500).send({
      error: "Erreur lors de la modification du Type",
    });
  }
};

const deleteOne = async (req, res) => {
  try {
    const id = req.params.id;

    // Suppression du sous type
    db.query("DELETE FROM types WHERE id = ?", [id], (err, result) => {
      if (err) {
        return res.status(500).json({
          error: "Erreur lors de la suppression du type",
        });
      }
      res.send({
        message: "Type supprimé avec succès",
      });
    });
  } catch (err) {
    console.log(err);
    res.status(500).send({
      error: "Erreur lors de la suppression du type",
    });
  }
};

const getAll = async (req, res) => {
  try {
    db.query("SELECT * FROM types", (err, rows) => {
      if (err) {
        return res.status(500).json({
          error: "Erreur lors de la récupération des types",
        });
      }
      res.send({
        types: rows,
      });
    });
  } catch (error) {
    console.log(error);
    res.status(500).send({
      error: "Erreur lors de la récupération des types",
    });
  }
};

module.exports = {
  create,
  updateOne,
  deleteOne,
  getAll,
};
