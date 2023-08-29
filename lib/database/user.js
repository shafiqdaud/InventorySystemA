const { Router } = require("express");
const router= Router();
var http = require('http')
const sqlite3 = require('sqlite3').verbose();
const express=require('express');
const app=express();
const dbHelper = require('./dataBaseExecute.js');


router.get('/user/get',(req,res)=>{

    db.serialize(function(){
        db.all('SELECT * FROM user',[], function(err,data){
            if(err){
                console.log(err);
                
            }else{
                console.log(data);
                
            }
        })
    })
})

router.post('/user/login', (req,res)=>{
    let data = req.body;
    const {email,password} = req.body;
    let sql = 'Select * from user where userName = ? and password = ? ';
    dbHelper.executeSelectCommand(sql, [], function(obj){
        console.log('123')
    })
})

module.exports=router;