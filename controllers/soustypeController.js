const db = require("../db");

const create = async (req, res) => {
  try {
    const { nom } = req.body;

    //insertion dans la base de données
    const [rows, fields] = await (
      await db
    ).query("INSERT INTO soustypes (nom_sous_type) VALUES (?)", [nom]);

    //envoi de la réponse
    res.send({
      message: "Sous type créé avec succès",
    });
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

    const [rows, fields] = await (
      await db
    ).query("UPDATE soustypes SET nom_sous_type = ? WHERE id = ?", [nom, id]);

    // Envoi de la réponse
    res.send({
      message: "Sous type modifié avec succès",
    });
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
    const [rows, fields] = await (
      await db
    ).query("DELETE FROM soustypes WHERE id = ?", [id]);

    // Envoi de la réponse
    res.send({
      message: "Sous type supprimé avec succès",
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
    const [rows, fields] = await (await db).query("SELECT * FROM soustypes");
    res.send({
      soustypes: rows,
    });
  } catch (error) {
    console.log(err);
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
