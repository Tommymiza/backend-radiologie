const db = require("../db");
const jwt = require("jsonwebtoken");
const transporter = require("../mailconfig");
const path = require("path");
const { socket: io } = require("../socket");

const formaDate = (dateString) => {
  const months = [
    "Janvier",
    "Février",
    "Mars",
    "Avril",
    "Mai",
    "Juin",
    "Juillet",
    "Août",
    "Septembre",
    "Octobre",
    "Novembre",
    "Décembre",
  ];

  const date = new Date(dateString);
  const day = date.getDate();
  const month = months[date.getMonth()];
  const year = date.getFullYear();

  return `${day} ${month} ${year}`;
};

const create = async (req, res) => {
  try {
    const {
      nom_patient,
      email,
      datenais,
      tel,
      rdv,
      id_type,
      id_medecin,
      code,
    } = req.body;
    if (
      !nom_patient ||
      !email ||
      !datenais ||
      !tel ||
      !code ||
      nom_patient === "" ||
      email === "" ||
      datenais === "" ||
      tel === "" ||
      code === ""
    ) {
      return res.status(401).json({
        error: "Veuillez remplir tous les champs",
      });
    }
    const files = req.file ? `/files/${req.file.filename}` : null;
    const rendez_vous = rdv === "null" ? null : rdv;
    const medecin = id_medecin === "null" ? null : id_medecin;
    if (!medecin) {
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
            "INSERT INTO demandes (nom_patient, email, datenais, tel, rdv, id_type, id_medecin, ordonnance) VALUES (?, ?, ?, ?, ?, ?,?, ?)",
            [
              nom_patient,
              email,
              datenais,
              tel,
              rendez_vous,
              id_type,
              files,
              medecin,
            ],
            async (err2, result2) => {
              if (err2) {
                return res.status(500).json({
                  error: "Erreur lors de la création de la demande",
                  message: err2,
                });
              }
              const linktoken = jwt.sign(
                { id: result2.insertId },
                process.env.JWT_SECRET
              );
              try {
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
              } catch (error) {
                console.log(error);
                res.status(500).send({ error: "Erreur de l'envoi de l'email" });
              }
            }
          );
        }
      );
    } else {
      console.log(id_medecin);
      db.query(
        "INSERT INTO demandes (nom_patient, email, datenais, tel, rdv, id_type,ordonnance, id_medecin) VALUES (?, ?, ?, ?, ?, ?,?, ?)",
        [
          nom_patient,
          email,
          datenais,
          tel,
          rendez_vous,
          id_type,
          files,
          medecin,
        ],
        async (err2, result2) => {
          if (err2) {
            return res.status(500).json({
              error: "Erreur lors de la création de la demande",
              message: err2,
            });
          }
          const linktoken = jwt.sign(
            { id: result2.insertId },
            process.env.JWT_SECRET
          );
          try {
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
          } catch (error) {
            console.log(error);
            res.status(500).send({ error: "Erreur de l'envoi de l'email" });
          }
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
    io.emit("get demande");
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
    if (!email || email === "") {
      return res.status(401).json({
        error: "Veuillez remplir tous les champs",
      });
    }
    const code = Math.floor(Math.random() * 1000000);
    const info = await transporter.sendMail({
      from: process.env.SMTP_USER,
      to: email,
      subject: "Code de confirmation",
      text: `Votre code de confirmation est ${code}`,
    });
    db.query(
      "INSERT INTO codes (email, code) VALUES (?, ?)",
      [email, code],
      async (err, result) => {
        if (err) {
          return res.status(500).json({
            error: "Erreur lors de la création du code",
          });
        }
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
      "SELECT demandes.id, demandes.nom_patient, demandes.email AS email, demandes.datenais, demandes.ordonnance, demandes.tel, demandes.created_at, demandes.rdv, COALESCE(users.nom, NULL) AS nom_medecin, types.nom_type, types.nom_sous_type, demandes.lieu,demandes.date_rdv FROM demandes INNER JOIN types ON demandes.id_type = types.id LEFT JOIN users ON demandes.id_medecin = users.id ORDER BY created_at DESC",
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
      "SELECT demandes.id, nom_patient, email, datenais, tel, created_at, rdv, id_medecin, nom_type, nom_sous_type, lieu, date_rdv FROM demandes, types WHERE demandes.id_type = types.id AND id_medecin = ?",
      [id_medecin],
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
    const { id, lieu, date_rdv } = req.body;
    if (!lieu || !date_rdv || lieu === "" || date_rdv === "") {
      return res.status(401).json({
        error: "Veuillez remplir tous les champs",
      });
    }
    db.query(
      "UPDATE demandes SET lieu = ?, date_rdv = ? WHERE id = ?",
      [lieu, date_rdv, id],
      (err, result) => {
        if (err) {
          return res.status(500).json({
            error: "Erreur lors de la modification du statut",
          });
        } else {
          // db.query(
          //   "SELECT d.email, d.nom_patient, d.lieu, d.date_rdv, t.nom_type, t.nom_sous_type FROM demandes d INNER JOIN types t ON d.id_type = t.id WHERE d.id = ?",
          //   [id],
          //   async (err, result) => {
          //     if (err || result.length === 0) {
          //       return res.status(401).json({
          //         error: "Demande inconnu",
          //       });
          //     } else {
          //       const {
          //         email,
          //         nom_patient,
          //         lieu,
          //         date_rdv,
          //         nom_type,
          //         nom_sous_type,
          //       } = result[0];
          //       try {
          //         const info = await transporter.sendMail({
          //           from: process.env.SMTP_USER,
          //           to: email,
          //           subject: "Demande radiologie",
          //           html: `
          //   <p> Bonjour ${nom_patient}, nous sommes ravis de vous confirmer votre rendez-vous pour l'examen d’imagerie médical ${nom_type} avec le type d'examen ${nom_sous_type}  le ${formaDate(
          //             date_rdv
          //           )}. Votre rendez-vous se tiendra à notre établissement situé à ${lieu}. Nous avons hâte de vous y accueillir.</p>
          // `,
          //         });
          //       } catch (error) {
          //         console.log(error);
          //         res
          //           .status(500)
          //           .send({ error: "Erreur de l'envoi de l'email" });
          //       }
          //     }
          //   }
          // );
          res.send({
            message: "Statut modifié avec succès",
          });
        }
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

    db.query(
      "SELECT d.email, d.nom_patient, d.lieu, d.date_rdv, t.nom_type, t.nom_sous_type FROM demandes d INNER JOIN types t ON d.id_type = t.id WHERE d.id = ?",
      [id],
      async (err, result) => {
        if (err || result.length === 0) {
          return res.status(401).json({
            error: "Demande inconnue",
          });
        } else {
          const {
            email,
            nom_patient,
            lieu,
            date_rdv,
            nom_type,
            nom_sous_type,
          } = result[0];

          try {
            await transporter.sendMail({
              from: process.env.SMTP_USER,
              to: email,
              subject: "Suppression du demande en radiologie",
              html: `
              <p> Bonjour ${nom_patient}, Nous vous informons que votre demande de rendez-vous médical a été annulée, soit en raison de détails dépassés, soit suite à votre souhait de ne pas poursuivre l'examen. Si vous avez des questions ou si vous souhaitez discuter de cette annulation, n'hésitez pas à nous contacter pour obtenir plus d'informations.</p>
            `,
            });

            db.query(
              "DELETE FROM demandes WHERE id = ?",
              [id],
              (err, result) => {
                if (err) {
                  return res.status(500).json({
                    error: "Erreur lors de la suppression de la demande",
                  });
                } else {
                  res.send({
                    message: "Demande supprimée avec succès",
                  });
                }
              }
            );
          } catch (error) {
            console.log(error);
            res.status(500).send({ error: "Erreur de l'envoi de l'email" });
          }
        }
      }
    );
  } catch (err) {
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
