const express= require('express');
const mongoose= require('mongoose');
const authRouter=require('./routes/auth');
const postRouter= require('./routes/post');
const likeRouter= require('./routes/like');
const commentRouter= require('./routes/comment');
const followRouter= require('./routes/follow');

const cors=require('cors');
const PORT=3000;

const app= express();

app.use(express.json());
app.use(cors());// enable cors for all routes origin
app.use(authRouter);
app.use(postRouter);
app.use(likeRouter);
app.use(commentRouter);
app.use(followRouter);

const DB='mongodb+srv://insta_db_user:inshal_khan@cluster0.4cmxk49.mongodb.net/?appName=Cluster0';
const dns = require("dns"); dns.setServers(["1.1.1.1", "8.8.8.8"]);
mongoose.connect(DB).then(()=>{
    console.log("mongoDB connected");
});

app.get('/hello',(req,res)=>{
    res.send('Hello world');
});

app.listen(PORT,'0.0.0.0',function(){
    console.log(`Server is running at ${PORT}`);
});