require("dotenv").config();
const cors = require("cors");
const globalRoutes = require("./routes/index.routes");
const db = require("./db");
const express = require("express");
const cron = require("node-cron");
const { socket: io, server, app } = require("./socket");
io.on("connection", async (socket) => {
  io.emit("online", {
    users: (await io.fetchSockets()).map((s) => ({
      id: s.handshake.query.id_user,
      lieu: s.handshake.query.lieu,
    })),
  });
  socket.on("online", async () => {
    io.emit("online", {
      users: (await io.fetchSockets()).map((s) => ({
        id: s.handshake.query.id_user,
        lieu: s.handshake.query.lieu,
      })),
    });
  });
  socket.on("join", (data) => {
    socket.join(data.room);
  });
  socket.on("get demande", () => {
    io.emit("get demande");
  });
  socket.on("leave", (data) => {
    socket.leave(data.room);
  });
  socket.on("message", async (data) => {
    try {
      let lu = 0;
      if ((await io.to(data.room).fetchSockets()).length === 2) {
        lu = 1;
      }
      db.query(
        "INSERT INTO messages (id_envoyeur, id_receveur, message, lu) VALUES (?, ?, ?, ?)",
        [data.id, data.dest_id, data.message, lu],
        (err, rows) => {
          if (err) {
            console.log(err);
            return;
          }
          db.query(
            "SELECT * FROM messages WHERE id = ?",
            rows.insertId,
            (err1, rows1) => {
              if (err1) {
                console.log(err1);
                return;
              }
              io.to(`roomuser-${data.dest_id}`).emit("newmessage");
              io.to(data.room).emit("message", rows1[0]);
            }
          );
        }
      );
    } catch (error) {
      console.log(error);
    }
  });
  socket.on("getMessages", (data) => {
    try {
      db.query(
        "SELECT * FROM messages WHERE (id_envoyeur = ? AND id_receveur = ?) OR (id_envoyeur = ? AND id_receveur = ?)",
        [data.id, data.dest_id, data.dest_id, data.id],
        (err, rows) => {
          if (err) {
            console.log(err);
            return;
          }
          io.to(data.room).emit("getMessages", rows);
          db.query(
            `UPDATE messages SET lu = 1 WHERE id_envoyeur = ? AND id_receveur = ?`,
            [data.dest_id, data.id],
            (err1, rows1) => {
              if (err1) {
                console.log(err1);
                return;
              }
              io.to(`roomuser-${data.id}`).emit("newmessage");
            }
          );
        }
      );
    } catch (error) {
      console.log(error);
    }
  });
  socket.on("disconnect", async (reason) => {
    io.emit("online", {
      users: (await io.fetchSockets()).map((s) => s.handshake.query.id_user),
    });
  });
});
app.use(
  cors({
    origin: "*",
    methods: ["GET", "POST", "PATCH", "DELETE", "PUT"],
  })
);
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use("/files", express.static("upload/files"));
app.use("/api", globalRoutes);

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

// Tâche cron planifiée à chaque  minuit  (00:00)
cron.schedule("05 00 * * *", () => {
  const sql = `DELETE FROM demandes WHERE rdv < CURDATE() AND (lieu = '' OR lieu IS NULL) AND rdv IS NOT NULL`;
  db.query(sql, (err, result) => {
    if (err) {
      console.error(
        "Erreur lors de la suppression des entrées dépassées :",
        err
      );
      return;
    }
    console.log(`${result?.affectedRows} demandes supprimées.`);
  });
});
server.listen(process.env.PORT, (err) => {
  if (err) throw err;
  console.log(`Server running on port: ${process.env.PORT}`);
});
