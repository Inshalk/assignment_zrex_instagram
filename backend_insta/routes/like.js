const express = require('express');
const likeRouter = express.Router();
const Like = require('../models/like');

// 1. LIKE A POST
// POST /api/likes/like/:postId
likeRouter.post('/api/like/:postId', async (req, res) => {
    try {
        const { userID } = req.body;
        const { postId } = req.params;

        // Check if the like already exists to prevent duplicates
        const existingLike = await Like.findOne({ postID: postId, userID });
        
        if (existingLike) {
            return res.status(400).json({ 
                success: false, 
                message: "You have already liked this post" 
            });
        }

        const newLike = new Like({ postID: postId, userID });
        await newLike.save();

        res.status(201).json({ 
            success: true, 
            message: "Post liked successfully" 
        });
    } catch (error) {
        res.status(500).json({ success: false, error: error.message });
    }
});

// 2. UNLIKE A POST
// DELETE /api/likes/unlike/:postId
likeRouter.delete('/api/unlike/:postId', async (req, res) => {
    try {
        const { userID } = req.body; // Pass userID in body to identify who is unliking
        const { postId } = req.params;

        const deletedLike = await Like.findOneAndDelete({ postID: postId, userID });

        if (!deletedLike) {
            return res.status(404).json({ 
                success: false, 
                message: "Like not found" 
            });
        }

        res.status(200).json({ 
            success: true, 
            message: "Post unliked successfully" 
        });
    } catch (error) {
        res.status(500).json({ success: false, error: error.message });
    }
});




module.exports = likeRouter;