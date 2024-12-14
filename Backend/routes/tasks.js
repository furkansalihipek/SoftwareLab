const express = require("express");
const router = express.Router();
const User = require("../models/User");
const Task = require("../models/Tasks");

router.post("/complete-task", async (req, res) => {
  const { userId, taskId } = req.body;

  try {
    const user = await User.findById(userId);
    if (!user) {
      return res.status(404).json({ message: "Kullanıcı bulunamadı" });
    }

    const task = await Task.findById(taskId);
    if (!task) {
      return res.status(404).json({ message: "Görev bulunamadı" });
    }

    user.completedTasks.push({ task: task._id, completedAt: new Date() });
    await user.save();

    res.status(200).json({ message: "Görev başarıyla tamamlandı" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Bir hata oluştu" });
  }
});

module.exports = router;