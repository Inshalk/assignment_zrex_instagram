const mongoose = require('mongoose');

const commentSchema = new mongoose.Schema({
  // PostID: References the post being commented on
  postID: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Post',
    required: [true, "Comment must belong to a post"],
    index: true // Optimized for "fetching all comments for a post"
  },
  // UserID: References the author of the comment
  userID: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: [true, "Comment must have an author"]
  },
  // Content: The actual text
  content: {
    type: String,
    required: [true, "Comment text cannot be empty"],
    trim: true,
    maxlength: [500, "Comment is too long (max 500 characters)"]
  },
  // CreatedAt: Automatic timestamp
  createdAt: {
    type: Date,
    default: Date.now
  }
});

const Comment= mongoose.model('Comment', commentSchema);
module.exports=Comment;