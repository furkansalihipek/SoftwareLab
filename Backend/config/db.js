const mongoose = require("mongoose");

const connectDB = async () => {
  try {
    await mongoose.connect(process.env.DB_URI, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });
    console.log("MongoDB Bağlantısı Başarılı");
  } catch (err) {
    console.error("MongoDB Bağlantı Hatası:", err.message);
    process.exit(1);
  }
};

module.exports = connectDB;