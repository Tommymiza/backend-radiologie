require("dotenv").config();
const express = require("express");
const cors = require("cors");
const globalRoutes = require("./routes/index.routes");

const app = express();

// Importation des middlewares
app.use(cors());
app.use(express.urlencoded({ extended: true }));

// Importation des routes
app.use("/api", globalRoutes);

// Route test
app.get("/", async (req, res) => {
  try {
    res.json({
      message: "Welcome to the API",
    });
  } catch (err) {
    console.log(err);
    res.sendStatus(500);
  }
});

// Ecoute du serveur
app.listen(process.env.PORT, (err) => {
  if (err) throw err;
  console.log(`Server running on port: ${process.env.PORT}`);
});
