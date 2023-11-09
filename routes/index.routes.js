const router = require("express").Router();

router
  .use("/user", require("./user.routes"))
  .use("/demande", require("./demande.routes"))
  .use("/type", require("./type.routes"))
  .use("/soustype", require("./soustype.routes"));

module.exports = router;
