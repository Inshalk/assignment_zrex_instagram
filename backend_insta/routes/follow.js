const express = require('express');
const followRouter = express.Router();
const Follow = require('../models/follow');

followRouter.post('/api/follow-user', async (req, res) => {
    try {
        const { followerID, followeeID } = req.body;

        if (followerID === followeeID) {
            return res.status(400).json({ message: "You cannot follow yourself" });
        }

        const newFollow = new Follow({ followerID, followeeID });
        await newFollow.save();

        res.status(201).json({ success: true, message: "User followed" });
    } catch (error) {
        res.status(400).json({ success: false, message: "Already following or error occurred" });
    }
});

// Inside your followRouter
followRouter.get('/api/user-stats/:userId', async (req, res) => {
    const { userId } = req.params;
    
    const followers = await Follow.countDocuments({ followeeID: userId });
    const following = await Follow.countDocuments({ followerID: userId });
    
    res.json({ success: true, followers, following });
});

module.exports=followRouter;