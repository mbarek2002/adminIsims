const mongoose  = require('mongoose');
// mongodb+srv://iheb:<password>@cluster0.iabvunr.mongodb.net/
// mongodb+srv://iheb:iheb@cluster0.iabvunr.mongodb.net/


mongoose.connect('mongodb+srv://iheb:iheb@cluster0.iabvunr.mongodb.net/isims',
{useNewUrlParser:true,useUnifiedTopology:true});

const db = mongoose.connection;

db.on('error',(err)=>{
    console.log(err);
})

db.once('open',()=>{
    console.log("Database Connection Established");
})

module.exports =db;
