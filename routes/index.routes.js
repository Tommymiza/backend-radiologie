const router = require("express").Router();
const path = require("path");
const demandeController = require("../controllers/demandeController");

router
  .get("/delete/demande", demandeController.deleteFromEmail)
  .use("/user", require("./user.routes"))
  .use("/demande", require("./demande.routes"))
  .use("/type", require("./type.routes"))
  .use("/soustype", require("./soustype.routes"));

module.exports = router;
