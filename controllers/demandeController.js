const db = require("../db");
const jwt = require("jsonwebtoken");
const transporter = require("../mailconfig");
const path = require("path");

const create = async (req, res) => {
  try {
    const {
      nom_patient,
      email,
      datenais,
      tel,
      rdv,
      id_type,
      id_sous_type,
      id_medecin,
      code,
    } = req.body;
    console.log(req.body);
    if (!id_medecin) {
      db.query(
        "SELECT code FROM codes WHERE email = ? AND code = ?",
        [email, code],
        (err, result) => {
          if (err || result.length === 0) {
            return res.status(401).json({
              error: "Code invalide",
            });
          }
          db.query(
            "DELETE FROM codes WHERE email = ? AND code = ?",
            [email, code],
            (err1, result1) => {
              if (err1) {
                return res.status(500).json({
                  error: "Erreur lors de la suppression du code",
                });
              }
            }
          );
          db.query(
            "INSERT INTO demandes (nom_patient, email, datenais, tel, rdv, id_type, id_sous_type, id_medecin) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
            [
              nom_patient,
              email,
              datenais,
              tel,
              rdv,
              id_type,
              id_sous_type,
              id_medecin,
            ],
            async (err2, result2) => {
              if (err2) {
                return res.status(500).json({
                  error: "Erreur lors de la création de la demande",
                });
              }
              const linktoken = jwt.sign(
                { id: result2.insertId },
                process.env.JWT_SECRET
              );
              const info = await transporter.sendMail({
                from: process.env.SMTP_USER,
                to: email,
                subject: "Demande radiologie",
                html: `
        <p>Bonjour ${nom_patient},</p>
        <p>Votre demande de rendez-vous a été prise en compte.</p>
        <p>Vous recevrez un email de confirmation dès qu'un médecin aura pris en charge votre demande.</p>
        <p>Si vous voulez supprimer la demande, veuillez cliquez sur ce bouton</p>
        <a href="${process.env.DOMAIN}/api/delete/demande?token=${linktoken}">Supprimer la demande</a>
      `,
              });
              res.send({
                message: "Demande ajoutée avec succès",
                id: result2.insertId,
              });
            }
          );
        }
      );
    } else {
      db.query(
        "INSERT INTO demandes (nom_patient, email, datenais, tel, rdv, id_type, id_sous_type, id_medecin) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
        [
          nom_patient,
          email,
          datenais,
          tel,
          rdv,
          id_type,
          id_sous_type,
          id_medecin,
        ],
        async (err2, result2) => {
          if (err2) {
            return res.status(500).json({
              error: "Erreur lors de la création de la demande",
            });
          }
          const linktoken = jwt.sign(
            { id: result2.insertId },
            process.env.JWT_SECRET
          );
          const info = await transporter.sendMail({
            from: process.env.SMTP_USER,
            to: email,
            subject: "Demande radiologie",
            html: `
    <p>Bonjour ${nom_patient},</p>
    <p>Votre demande de rendez-vous a été prise en compte.</p>
    <p>Vous recevrez un email de confirmation dès qu'un médecin aura pris en charge votre demande.</p>
    <p>Si vous voulez supprimer la demande, veuillez cliquez sur ce bouton</p>
    <a href="${process.env.DOMAIN}/api/delete/demande?token=${linktoken}">Supprimer la demande</a>
  `,
          });
          res.send({
            message: "Demande ajoutée avec succès",
            id: result2.insertId,
          });
        }
      );
    }
  } catch (err) {
    console.log(err);
    res.status(500).send({
      error: "Erreur lors de la création de la demande",
    });
  }
};

const deleteFromEmail = async (req, res) => {
  try {
    const token = req.query.token;
    const decodedToken = jwt.verify(token, process.env.JWT_SECRET);
    console.log(decodedToken);
    if (!decodedToken) {
      return res.status(401).json({
        error: "Requête invalide !",
      });
    }
    db.query("DELETE FROM demandes WHERE id = ?", [decodedToken.id]);
    res.sendFile(path.join(__dirname, "../views/deleteDemande.html"));
  } catch (error) {
    console.log(error);
    res.status(500).send({
      error: "Erreur lors de la suppression de la demande",
    });
  }
};

const sendCodeConfirmation = async (req, res) => {
  try {
    const { email } = req.body;
    const code = Math.floor(Math.random() * 1000000);
    console.log(code);
    db.query(
      "INSERT INTO codes (email, code) VALUES (?, ?)",
      [email, code],
      async (err, result) => {
        if (err) {
          return res.status(500).json({
            error: "Erreur lors de la création du code",
          });
        }
        const info = await transporter.sendMail({
          from: process.env.SMTP_USER,
          to: email,
          subject: "Code de confirmation",
          text: `Votre code de confirmation est ${code}`,
        });
        return res.send({
          message: "Code envoyé avec succès",
        });
      }
    );
  } catch (err) {
    console.log(err);
    res.status(500).send({
      error: "Erreur lors de l'envoi du code",
    });
  }
};

const getAll = async (req, res) => {
  try {
    db.query(
      "SELECT demandes.id, nom_patient, email, datenais, tel, created_at, rdv, status, id_medecin, nom_type, nom_sous_type FROM demandes, types, soustypes WHERE demandes.id_type = types.id AND demandes.id_sous_type = soustypes.id",
      (err, result) => {
        if (err) {
          return res.status(500).json({
            error: "Erreur lors de la récupération des demandes",
          });
        }
        return res.send({
          demandes: result,
        });
      }
    );
  } catch (err) {
    console.log(err);
    res.status(500).send({
      error: "Erreur lors de la récupération des demandes",
    });
  }
};
const getMine = async (req, res) => {
  try {
    const token = req.headers.authorization.split(" ")[1];
    const decodedToken = jwt.verify(token, process.env.JWT_SECRET);
    if (!decodedToken) {
      return res.status(401).json({
        error: "Requête invalide !",
      });
    }
    const id_medecin = decodedToken.id;
    db.query(
      "SELECT demandes.id, nom_patient, email, datenais, tel, created_at, rdv, status, id_medecin, nom_type, nom_sous_type FROM demandes, types, soustypes WHERE demandes.id_type = types.id AND demandes.id_sous_type = soustypes.id AND id_medecin = ?",[id_medecin],
      (err, result) => {
        if (err) {
          return res.status(500).json({
            error: "Erreur lors de la récupération des demandes",
          });
        }
        return res.send({
          demandes: result,
        });
      }
    );
  } catch (err) {
    console.log(err);
    res.status(500).send({
      error: "Erreur lors de la récupération des demandes",
    });
  }
};

const changeStatus = async (req, res) => {
  try {
    const { id, status } = req.body;
    db.query(
      "UPDATE demandes SET status = ? WHERE id = ?",
      [status, id],
      (err, result) => {
        if (err) {
          return res.status(500).json({
            error: "Erreur lors de la modification du statut",
          });
        }
        res.send({
          message: "Statut modifié avec succès",
        });
      }
    );
  } catch (err) {
    console.log(err);
    res.status(500).send({
      error: "Erreur lors de la modification du statut",
    });
  }
};

const deleteOne = async (req, res) => {
  try {
    const id = req.params.id;
    db.query("DELETE FROM demandes WHERE id = ?", [id], (err, result) => {
      if (err) {
        return res.status(500).json({
          error: "Erreur lors de la suppression de la demande",
        });
      }
      res.send({
        message: "Demande supprimée avec succès",
      });
    });
  } catch (err) {
    console.log(err);
    res.status(500).send({
      error: "Erreur lors de la suppression de la demande",
    });
  }
};

const deleteMine = async (req, res) => {
  try {
    const token = req.params.token;
    const decodedToken = jwt.verify(token, process.env.JWT_SECRET);
    if (!decodedToken) {
      return res.status(401).json({
        error: "Requête invalide !",
      });
    }
    db.query(
      "DELETE FROM demandes WHERE id = ?",
      [decodedToken.id],
      (err, result) => {
        if (err) {
          return res.status(500).json({
            error: "Erreur lors de la suppression de la demande",
          });
        }
        res.send({
          message: "Demande supprimée avec succès",
        });
      }
    );
  } catch (err) {
    console.log(err);
    res.status(500).send({
      error: "Erreur lors de la suppression de la demande",
    });
  }
};

module.exports = {
  create,
  getAll,
  getMine,
  changeStatus,
  deleteOne,
  deleteMine,
  deleteFromEmail,
  sendCodeConfirmation,
};
