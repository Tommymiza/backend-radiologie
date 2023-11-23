const router = require("express").Router();
const demandeController = require("../controllers/demandeController");
const db = require("../db");

router
  .get("/delete/demande", demandeController.deleteFromEmail)
  .use("/user", require("./user.routes"))
  .use("/demande", require("./demande.routes"))
  .use("/type", require("./type.routes"))
  .get("/message/getmessagenonlu", async (req, res) => {
    const { id } = req.query;
    db.query(
      "SELECT COUNT(*) as count FROM messages WHERE id_receveur = ? AND lu = 0",
      [id],
      (err, rows) => {
        if (err) {
          console.log(err);
          res.status(500).send(err);
        }
        res.send(rows[0]);
      }
    );
  });

module.exports = router;
