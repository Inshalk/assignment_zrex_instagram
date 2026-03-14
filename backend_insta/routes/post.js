const express = require('express');
const postRouter = express.Router();
const Post = require('../models/post'); // Import the model you created

postRouter.post('/api/user/create-post', async (req, res) => {
    try {
        const { userID, contentURL, caption } = req.body;
        
        const newPost = new Post({
            userID,
            contentURL,
            caption
        });
        
        const savedPost = await newPost.save();

        res.status(201).json(savedPost);
    } catch (error) {
        
        res.status(400).json({ message: error.message });
    }
});

postRouter.get('/api/user/:userId',async(req,res)=>{
    try {
        const {userId}=req.params;
        const posts= await Post.find({userId});
        if(posts.length==0){
            return res.status(404).json({msg:"No posts found "});
        }
        return res.status(200).json(posts);
    } catch (e) {
        res.status(500).json({error:e.message});
    }
    
});

postRouter.delete('/api/orders/:id',async (req,res)=>{
    try {
        const {id}=req.params;
        const deletedPost=await Posts.findByIdAndDelete(id);
        if(!deletedPost){
            return res.status(404).json({msg:"Post Not Found"});
        }else{
            return res.status(200).json({msg:"Post Was deleted successfully"});
        }
    } catch (e) {
         res.status(500).json({error:e.message});
    }
});

postRouter.get('/api/post-stats/:postId', async (req, res) => {
    const { postId } = req.params;
    const likeCount = await Like.countDocuments({ postID: postId });
    res.json({ success: true, likes: likeCount });
});
module.exports = postRouter;