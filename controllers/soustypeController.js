const db = require("../db");

const create = async (req, res) => {
  try {
    const { nom_type, nom_sous_type } = req.body;
    if (
      nom_type == null ||
      nom_sous_type == null ||
      nom_type == "" ||
      nom_sous_type == ""
    ) {
      return res.status(400).json({
        error: "Champ invalide!",
      });
    }
    //insertion dans la base de données
    db.query(
      "INSERT INTO types (nom_type, nom_sous_type) VALUES (?, ?)",
      [nom_type, nom_sous_type],
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
    const { id, nom_sous_type } = req.body;

    db.query(
      "UPDATE types SET nom_sous_type = ? WHERE id = ?",
      [nom_sous_type, id],
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

module.exports = {
  create,
  updateOne,
  deleteOne,
};
