const express= require('express');
const mongoose= require('mongoose');
const authRouter=require('./routes/auth');
const postRouter= require('./routes/post');
const likeRouter= require('./routes/like');
const commentRouter= require('./routes/comment');
const followRouter= require('./routes/follow');
require("dotenv").config();

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

const dns = require("dns"); dns.setServers(["1.1.1.1", "8.8.8.8"]);
mongoose.connect(process.env.DATABASE).then(()=>{
    console.log("MongoDB Connected");
});

app.get('/hello',(req,res)=>{
    res.send('Hello world');
});

app.listen(PORT,'0.0.0.0',function(){
    console.log(`Server is running at ${PORT}`);
});