require("dotenv").config();
const express = require("express");
const mongoose = require("mongoose");
const bodyParser = require("body-parser");
const cors = require("cors");
const tasksRoute = require("./routes/tasks");
const userRoute = require('./routes/users');

const app = express();

app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.use("/tasks", tasksRoute);
app.use("/users", userRoute);

const dbURI = process.env.DB_URI || "mongodb://localhost:27017/softwarelab";
mongoose.connect(dbURI, { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => console.log("MongoDB'ye bağlanıldı"))
  .catch(err => console.log("MongoDB'ye bağlanırken hata:", err));

const PORT = process.env.PORT || 4000;
app.listen(PORT, () => {
  console.log(`Sunucu ${PORT} portunda çalışıyor`);
});