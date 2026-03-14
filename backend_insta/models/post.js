const mongoose = require('mongoose');

const postSchema = new mongoose.Schema({
  // Mongoose creates a unique _id by default, which serves as your PostID
  userID: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User', // This must match the name of your User model
    required: true,
    index: true // Speeds up queries for a specific user's feed
  },
  contentURL: {
    type: String,
    required: [true, "Post must have an image or video URL"],
    trim: true
  },
  caption: {
    type: String,
    maxlength: [2200, "Caption cannot exceed 2200 characters"],
    default: ""
  },
  createdAt: {
    type: Date,
    default: Date.now // Automatically sets the timestamp
  }
});
const Post = mongoose.model("Post" , postSchema );
module.exports = Post;