var http = require('http')
const sqlite3 = require('sqlite3').verbose();
const express=require('express');
const app=express();

app.set('port',process.env.PORT ||4000);


//Middlewares
app.use(express.json());

//routes
app.use((require('./user')));


var db;
app.listen(8080, ()=>{
    db = new sqlite3.Database('C:/ProgramData/inventory/ois.db', sqlite3.OPEN_READWRITE, (err)=> {
        if(err){
            console.log(err.message);
        }else{
            console.log('Db connected')
        }
    })  
    console.log('app working on port 8080');

})

module.exports = db;




