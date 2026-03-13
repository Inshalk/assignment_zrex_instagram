const express= require('express');
const PORT=3000;

const app= express();

app.get('/hello',(req,res)=>{
    res.send('Hello world');
});

app.listen(PORT,'0.0.0.0',function(){
    console.log(`Server is running at ${PORT}`);
});