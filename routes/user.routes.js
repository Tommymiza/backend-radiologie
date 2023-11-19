const router = require("express").Router();
const userController = require("../controllers/userController");
const auth = require("../middlewares/authentication");

router
  .get("/", auth(["admin", "medecin", "radiologue"]), userController.getAll)
  .get("/all", auth(["medecin"]), userController.getAllType)
  .get("/all-radiologue", auth(["radiologue"]), userController.getAllRadiologue)
  .post("/add", auth(["admin"]), userController.create)
  .post("/signup", userController.signup)
  .post("/verify", auth(["admin"]), userController.verifyMedecin)
  .put("/update", auth(["admin", "medecin"]), userController.updateOne)
  .delete("/delete/:id", auth(["admin"]), userController.deleteOne)
  .post(
    "/logout",
    auth(["admin", "radiologue", "medecin"]),
    userController.logout
  )
  .post("/login/:role", userController.login)
  .get("/check/:role", userController.checkConnectedUser);

module.exports = router;
