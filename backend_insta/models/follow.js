const mongoose = require('mongoose');

const followSchema = new mongoose.Schema({
  followerID: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true,
    index: true
  },
  followeeID: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true,
    index: true
  },
  createdAt: {
    type: Date,
    default: Date.now
  }
});

// Prevent duplicate follows
followSchema.index({ followerID: 1, followeeID: 1 }, { unique: true });

module.exports = mongoose.model('Follow', followSchema);