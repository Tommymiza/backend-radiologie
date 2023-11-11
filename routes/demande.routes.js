const router = require("express").Router();
const auth = require("../middlewares/authentication");
const demandeController = require("../controllers/demandeController");

router
  .get("/", auth(["admin", "radiologue"]), demandeController.getAll)
  .put("/update", auth(["admin", "radiologue"]), demandeController.changeStatus)
  .post("/sendcode", demandeController.sendCodeConfirmation)
  .delete(
    "/delete/:id",
    auth(["admin", "radiologue", "medecin"]),
    demandeController.deleteOne
  )
  .post("/add", demandeController.create)
  .delete("/delete/email/:token", demandeController.deleteMine);

module.exports = router;
