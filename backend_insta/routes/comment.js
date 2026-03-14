const express = require('express');
const Comment=require('../models/comment');
const  commentRouter = express.Router();

commentRouter.post('/api/posts/:postId/comments', async (req, res) => {
    try {
        const { userID, content } = req.body;
        const { postId } = req.params; // Gets the ID from the URL

        const newComment = new Comment({
            postID: postId,
            userID,
            content
        });

        await newComment.save();
        res.status(201).json(newComment);
    } catch (error) {
        res.status(400).json({ message: error.message });
    }
});

commentRouter.delete('/api/delete-comment/:commentId', async (req, res) => {
    try {
        const { commentId } = req.params;

        // Find the comment by ID and remove it
        const deletedComment = await Comment.findByIdAndDelete(commentId);

        // If no comment was found with that ID
        if (!deletedComment) {
            return res.status(404).json({ 
                success: false, 
                message: "Comment not found. It might have already been deleted." 
            });
        }

        res.status(200).json({
            success: true,
            message: "Comment deleted successfully",
            data: deletedComment
        });

    } catch (error) {
        res.status(500).json({ 
            success: false, 
            message: "Server error while deleting comment", 
            error: error.message 
        });
    }
});

module.exports=commentRouter;