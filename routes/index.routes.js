const router = require("express").Router();

router
  .use("/user", require("./user.routes"))
  .use("/demande", require("./demande.routes"));

module.exports = router;
