const db = require("../db");

const create = async (req, res) => {
  try {
    const { nom } = req.body;

    //insertion dans la base de données
    db.query(
      "INSERT INTO soustypes (nom_sous_type) VALUES (?)",
      [nom],
      (err, result) => {
        if (err) {
          return res.status(500).json({
            error: "Erreur lors de la création du sous type",
          });
        }
        res.send({
          message: "Sous type créé avec succès",
        });
      }
    );
  } catch (err) {
    console.log(err);
    res.status(500).send({
      error: "Erreur lors de la création du sous type",
    });
  }
};

const updateOne = async (req, res) => {
  try {
    const { id, nom } = req.body;

    db.query(
      "UPDATE soustypes SET nom_sous_type = ? WHERE id = ?",
      [nom, id],
      (err, result) => {
        if (err) {
          return res.status(500).json({
            error: "Erreur lors de la modification du sous type",
          });
        }
        res.send({
          message: "Sous type modifié avec succès",
        });
      }
    );
  } catch (err) {
    console.log(err);
    res.status(500).send({
      error: "Erreur lors de la modification du sous type",
    });
  }
};

const deleteOne = async (req, res) => {
  try {
    const id = req.params.id;
    // Suppression du sous type
    db.query("DELETE FROM soustypes WHERE id = ?", [id], (err, result) => {
      if (err) {
        return res.status(500).json({
          error: "Erreur lors de la suppression du sous type",
        });
      }
      res.send({
        message: "Sous type supprimé avec succès",
      });
    });
  } catch (err) {
    console.log(err);
    res.status(500).send({
      error: "Erreur lors de la suppression du sous type",
    });
  }
};

const getAll = async (req, res) => {
  try {
    db.query("SELECT * FROM soustypes", (err, rows) => {
      if (err) {
        return res.status(500).json({
          error: "Erreur lors de la récupération des sous types",
        });
      }
      res.send({
        soustypes: rows,
      });
    });
  } catch (error) {
    console.log(error);
    res.status(500).send({
      error: "Erreur lors de la récupération des sous types",
    });
  }
};

module.exports = {
  create,
  updateOne,
  deleteOne,
  getAll,
};
