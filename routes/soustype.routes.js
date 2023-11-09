const router = require("express").Router();
const auth = require("../middlewares/authentication");
const soustypeController = require("../controllers/soustypeController");

router
  .get("/", soustypeController.getAll)
  .post("/add", auth(["admin"]), soustypeController.create)
  .put("/update", auth(["admin"]), soustypeController.updateOne)
  .delete("/delete/:id", auth(["admin"]), soustypeController.deleteOne);

module.exports = router;
