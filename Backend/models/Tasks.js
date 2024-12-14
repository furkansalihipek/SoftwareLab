const mongoose = require("mongoose");

const taskSchema = new mongoose.Schema({
  title: {
    type: String,
    required: true,
  },
  description: {
    type: String,
    required: true,
  },
  reward: {
    type: Number,
    required: true,
  },
  solution: {
    type: String,
    required: true,
  },
});

const Task = mongoose.model("Tasks", taskSchema);

module.exports = Task;
