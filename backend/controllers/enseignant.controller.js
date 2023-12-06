const {response} = require('express');
const Etudiant = require('../models/Etudiant.model');
const userModel = require('../models/user.model');
const bcrypt = require('bcrypt');
const Enseignant = require('../models/Enseignant.model');


const addEnseignant = (req,res,next)=>{
    try{
        let enseignant = new userModel({
            nomComplet:req.body.nomComplet,
            cin:req.body.cin,
            numInsc:req.body.numInsc,
            email:req.body.email,
            phone:req.body.phone,
            photo:req.body.photo,
            cv:req.body.cv,
            titre:req.body.titre,
            role:"enseignant",
        });

        // enseignant=userModel({
        //     nomComplet:"test test",
        //     cin:"12222222224",
        //     numInsc:"22556699",
        //     email:"iheb202@gmail.com",
        //     phone:"22558877",
        //     photo:"",
        //     cv:"",
        //     titre:"maitre assistant",
        //     role:"enseignant"
        // });

        console.log(req.body);
        const randomPassword = generateRandomPassword(12);

        
        enseignant.save(randomPassword)
        .then(response=>{
            res.json({
                status:true,
                message:" Enseignant ajoute avec succès",
                password:randomPassword
            })
        })
        .catch(err=>{
            res.json({
                status: false,
                message: "An error occurred. No data saved in either table."
            });      
            throw err


        })

            

       

        // register.save()
        // .then(response=>{
        //     res.json({
        //         status:true,
        //         message:"Etudiant added succeffuly"
        //     })
        // })
        // .catch(error =>{
        //     res.json({
        //         status:false,
        //         message:"An error Occured!"
        //     })
        // })
    }catch(err){
        throw err
    }

}


function generateRandomPassword(length) {
    const uppercaseChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const lowercaseChars = 'abcdefghijklmnopqrstuvwxyz';
    const numericChars = '0123456789';
    const specialChars = '!@#$%^&*()-_+=<>?';
  
    const allChars =
      uppercaseChars + lowercaseChars + numericChars + specialChars;
  
    let password = '';
  
    for (let i = 0; i < length; i++) {
      const randomIndex = Math.floor(Math.random() * allChars.length);
      password += allChars.charAt(randomIndex);
    }
    console.log(password);
    return password;
  }


  const getEnseignant=async(req,res,next)=>{
    try{

        let enseignantList = await userModel.find({role:"enseignant"});

        console.log(enseignantList);

        res.json({status:true,success:enseignantList});

    }catch(err){
        throw err
    }
}

module.exports ={
    addEnseignant,getEnseignant
}