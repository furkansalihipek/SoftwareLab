const express = require("express");
const jwt = require("jsonwebtoken");
const User = require("../models/User");
const Task = require("../models/Tasks");
const router = express.Router();

// Kullanıcı Kayıt (Register)
router.post('/register', async (req, res) => {
  const { username, email, password } = req.body;

  // Eksik alan kontrolü
  if (!username || !email || !password) {
    return res.status(400).json({ message: 'Tüm alanlar zorunludur.' });
  }

  try {
    // Email veya username'in benzersiz olduğundan emin olun
    const existingUser = await User.findOne({ 
      $or: [{ email }, { username }] 
    });

    if (existingUser) {
      return res.status(400).json({ message: 'Email veya kullanıcı adı zaten kullanılıyor.' });
    }

    // Yeni kullanıcı oluştur
    const newUser = new User({ username, email, password });
    await newUser.save();

    res.status(201).json({ message: 'Kullanıcı başarıyla oluşturuldu.' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Kullanıcı oluşturulurken bir hata oluştu.' });
  }
});



// Kullanıcı Giriş (Login)
router.post('/login', async (req, res) => {
  const { email, password } = req.body;

  // Eksik alan kontrolü
  if (!email || !password) {
    return res.status(400).json({ message: 'Email ve şifre zorunludur.' });
  }

  try {
    // Kullanıcıyı email üzerinden ara
    const user = await User.findOne({ email });
    if (!user) {
      return res.status(400).json({ message: 'Geçersiz email veya şifre.' });
    }

    // Şifre doğrulama
    if (user.password !== password) {
      return res.status(400).json({ message: 'Geçersiz email veya şifre.' });
    }

    // JWT token oluştur
    const token = jwt.sign({ id: user._id, email: user.email }, process.env.JWT_SECRET, { expiresIn: '1h' });

    res.json({ message: 'Giriş başarılı', token });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Giriş işlemi sırasında bir hata oluştu.' });
  }
});


router.post("/complete-task", async (req, res) => {
  const { userId, taskId } = req.body;

  try {
    const user = await User.findById(userId);
    if (!user) {
      return res.status(400).json({ message: "Kullanıcı bulunamadı." });
    }

    const task = await Task.findById(taskId);
    if (!task) {
      return res.status(400).json({ message: "Görev bulunamadı." });
    }

    user.completedTasks.push({ task: task._id });
    await user.save();

    res.status(200).json({ message: "Görev tamamlandı.", user });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Bir hata oluştu." });
  }
});

router.get("/:userId/completed-tasks", async (req, res) => {
  try {
    const user = await User.findById(req.params.userId).populate("completedTasks.task");
    if (!user) {
      return res.status(404).json({ message: "Kullanıcı bulunamadı" });
    }

    res.status(200).json(user.completedTasks);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Bir hata oluştu" });
  }
});

module.exports = router;
