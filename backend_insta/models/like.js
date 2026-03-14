const mongoose = require('mongoose');

const likeSchema = new mongoose.Schema({
  postID: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Post',
    required: true,
    index: true 
  },
  userID: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true
  },
  createdAt: {
    type: Date,
    default: Date.now
  }
});

// This line prevents a user from liking the same post twice
likeSchema.index({ postID: 1, userID: 1 }, { unique: true });

module.exports = mongoose.model('Like', likeSchema);