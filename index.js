require("dotenv").config();
const cors = require("cors");
const globalRoutes = require("./routes/index.routes");
const db = require("./db");
const express = require("express");
const cron = require("node-cron");
const { socket: io, server, app } = require("./socket");
const transporter = require("./mailconfig");
io.on("connection", async (socket) => {
  let users = (await io.fetchSockets()).map((s) => ({
    id: s.handshake.query.id_user,
    lieu: s.handshake.query.lieu,
  }));
  db.query(
    "SELECT * FROM users WHERE role = 'radiologue' OR role = 'admin' OR role = 'secretaire'",
    async (err, rows1) => {
      if (err) {
        console.log(err);
        return;
      }
      users = rows1.map((u) => {
        const user = users.find((r) => r.id == u.id);
        if (user) {
          return {
            ...u,
            lieu: user.lieu,
          };
        }
        return u;
      });

      for (let i of rows1) {
        const last_message = await new Promise((resolve, reject) => {
          db.query(
            `SELECT * FROM messages WHERE id_envoyeur = ?  OR id_receveur = ? ORDER BY created_at DESC LIMIT 1`,
            [i.id, i.id],
            (err, rows) => {
              if (err) {
                console.log(err);
                reject(err);
                return;
              }
              if (rows.length === 0) {
                resolve(null);
                return;
              }
              resolve(rows[0]);
            }
          );
        });
        users = users.map((u) => {
          if (u.id == i.id) {
            return {
              ...u,
              last_message,
            };
          }
          return u;
        });
      }
      io.emit("online", {
        users,
      });
    }
  );
  socket.on("online", async () => {
    let users = (await io.fetchSockets()).map((s) => ({
      id: s.handshake.query.id_user,
      lieu: s.handshake.query.lieu,
    }));
    db.query(
      "SELECT * FROM users WHERE role = 'radiologue' OR role = 'admin' OR role = 'secretaire'",
      async (err, rows1) => {
        if (err) {
          console.log(err);
          return;
        }
        users = rows1.map((u) => {
          const user = users.find((r) => r.id == u.id);
          if (user) {
            return {
              ...u,
              lieu: user.lieu,
            };
          }
          return u;
        });

        for (let i of rows1) {
          const last_message = await new Promise((resolve, reject) => {
            db.query(
              `SELECT * FROM messages WHERE id_envoyeur = ?  OR id_receveur = ? ORDER BY created_at DESC LIMIT 1`,
              [i.id, i.id],
              (err, rows) => {
                if (err) {
                  console.log(err);
                  reject(err);
                  return;
                }
                if (rows.length === 0) {
                  resolve(null);
                  return;
                }
                resolve(rows[0]);
              }
            );
          });
          users = users.map((u) => {
            if (u.id == i.id) {
              return {
                ...u,
                last_message,
              };
            }
            return u;
          });
        }
        io.emit("online", {
          users,
        });
      }
    );
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
              io.emit("newdata");
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
              io.emit("newdata");
            }
          );
        }
      );
    } catch (error) {
      console.log(error);
    }
  });
  socket.on("disconnect", async (reason) => {
    let users = (await io.fetchSockets()).map((s) => ({
      id: s.handshake.query.id_user,
      lieu: s.handshake.query.lieu,
    }));
    db.query(
      "SELECT * FROM users WHERE role = 'radiologue' OR role = 'admin' OR role = 'secretaire'",
      async (err, rows1) => {
        if (err) {
          console.log(err);
          return;
        }
        users = rows1.map((u) => {
          const user = users.find((r) => r.id == u.id);
          if (user) {
            return {
              ...u,
              lieu: user.lieu,
            };
          }
          return u;
        });

        for (let i of rows1) {
          const last_message = await new Promise((resolve, reject) => {
            db.query(
              `SELECT * FROM messages WHERE id_envoyeur = ?  OR id_receveur = ? ORDER BY created_at DESC LIMIT 1`,
              [i.id, i.id],
              (err, rows) => {
                if (err) {
                  console.log(err);
                  reject(err);
                  return;
                }
                if (rows.length === 0) {
                  resolve(null);
                  return;
                }
                resolve(rows[0]);
              }
            );
          });
          users = users.map((u) => {
            if (u.id == i.id) {
              return {
                ...u,
                last_message,
              };
            }
            return u;
          });
        }
        io.emit("online", {
          users,
        });
      }
    );
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
// cron.schedule("05 00 * * *", () => {
//   const sql = `DELETE FROM demandes WHERE rdv < CURDATE() AND (lieu = '' OR lieu IS NULL) AND rdv IS NOT NULL`;
//   db.query(sql, (err, result) => {
//     if (err) {
//       console.error(
//         "Erreur lors de la suppression des entrées dépassées :",
//         err
//       );
//       return;
//     }
//     console.log(`${result?.affectedRows} demandes supprimées.`);
//   });
// });

// Tâche cron planifiée à chaque  minuit  (00:05)
cron.schedule("05 00 * * *", () => {
  const sql = `SELECT email FROM demandes  WHERE rdv < CURDATE() AND (lieu = '' OR lieu IS NULL) AND rdv IS NOT NULL`;
  db.query(sql, async (err, rows) => {
    if (err) {
      console.error("Error querying database:", err);
      return;
    }

    if (rows.length > 0) {
      const emails = rows.map((item) => item.email);
      await transporter.sendMail({
        from: process.env.SMTP_USER,
        to: emails,
        subject: "Suppression de la demande",
        html: `
            <p>Madame, Monsieur, </p>
            <p>Nous regrettons de ne pouvoir donner suite à votre demande de rendez-vous dans le délai souhaité. </p>
            <p>Nous vous remercions de votre compréhension. </p>
            <p>Bonne journée </p>
            <p style="color: #652191; font-size:20px">Centres d'Imagerie Médicale </p>
            <p style="color: #652191; font-size:20px">Radiologie91</p>
            <div><a href="${process.env.FRONT_URL}">${process.env.FRONT_URL}<a/></div>
            `,
      });

      // Perform deletion after sending emails
      const deleteSQL = `DELETE FROM demandes WHERE rdv < CURDATE() AND (lieu = '' OR lieu IS NULL) AND rdv IS NOT NULL`;
      db.query(deleteSQL, (deleteErr, result) => {
        if (deleteErr) {
          console.error("Error deleting entries:", deleteErr);
          return;
        }
        console.log(`${result?.affectedRows} demandes supprimées.`);
      });
    } else {
      console.log("No entries to delete.");
    }
  });
});

server.listen(process.env.PORT, (err) => {
  if (err) throw err;
  console.log(`Server running on port: ${process.env.PORT}`);
});
