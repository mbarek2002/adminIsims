const {response} = require('express');
const Etudiant = require('../models/Etudiant.model');
const userModel = require('../models/user.model');
const bcrypt = require('bcrypt');
const multer = require('multer');


//storage 
const Storage = multer.diskStorage({
    destination:'uploads',
    filename:(req,file,cb)=>{
        cb(null,file.originalname);
    }
})

const upload = multer({
    storage:Storage
}).single('photo')


const addEtudiantnew = async (req, res) => {
    try {
        const randomPassword = generateRandomPassword(12);
        console.log(req.file)

        if (req.fileValidationError) {
            return res.status(400).json({
                status: false,
                message: req.fileValidationError,
            });
        }

        const mimetype = req.file.mimetype ;

        const register = new userModel({
            nomComplet: req.body.nomComplet,
            cin: req.body.cin,
            numInsc: req.body.numInsc,
            email: req.body.email,
            phone: req.body.phone,
            filiere: req.body.filiere,
            classe: req.body.classe,
            role: 'etudiant',
            photoName:req.file.filename,
            photo: {
                data:req.file.filename,
                contentType: mimetype,
            },
        });

        const savedUser = await register.save(randomPassword);

        res.json({
            status: true,
            message: 'Etudiant ajoutée avec succès',
            password: randomPassword,
            user: savedUser,
        });
    } catch (error) {
        console.error('Error:', error);
        res.status(500).json({
            status: false,
            message: 'Internal Server Error',
        });
    }
};

const addEtudiant = async (req, res, next) => {
    try {
        const randomPassword = generateRandomPassword(12);

        console.log(req.body);
        console.log(req.file);

        upload(req, res, (err) => {
            if (err) {
                console.error(err);
                return res.status(500).json({
                    status: false,
                    message: 'Échec du téléchargement du fichier',
                });
            }

            console.log(req.file);

            const register = new userModel({
                nomComplet: req.body.nomComplet,
                cin: req.body.cin,
                numInsc: req.body.numInsc,
                email: req.body.email,
                phone: req.body.phone,
                filiere: req.body.filiere,
                classe: req.body.classe,
                role: 'etudiant',
                photo: {
                    data: req.file.filename, 
                    contentType: req.file.mimetype,
                },
            });

            register.save(randomPassword)
                .then(response => {
                    res.json({
                        status: true,
                        message: 'Etudiant ajoutée avec succès',
                        password: randomPassword,
                    });
                })
                .catch(err => {
                    console.error(err);
                    res.status(500).json({
                        status: false,
                        message: 'Error saving to database',
                    });
                });
        });

    } catch (error) {
        console.error(error);
        res.status(500).json({
            status: false,
            message: 'Internal Server Error',
        });
    }
};


// const addEtudiant = (req,res,next)=>{
//     try{
//         // let etudiant = new Etudiant({
//         //     nomComplet:req.body.nomComplet,
//         //     cin:req.body.cin,
//         //     numInsc:req.body.numInsc,
//         //     email:req.body.email,
//         //     phone:req.body.phone,
//         //     photo:req.body.photo,
//         //     filiere:req.body.filiere,
//         //     classe:req.body.classe
//         // });

//         // etudiant=Etudiant({
//         //     nomComplet:"test test",
//         //     cin:12222222224,
//         //     numInsc:"54548",
//         //     email:"iheb202@gmail.com",
//         //     phone:"22558877",
//         //     photo:"",
//         //     filiere:"PIINFO",
//         //     classe:"TD88"
//         // });

//         upload(req,res,(err)=>{
//             console.log(req.file);

//             let register = new userModel({
//                 nomComplet:req.body.nomComplet,
//                 cin:req.body.cin,
//                 numInsc:req.body.numInsc,
//                 email:req.body.email,
//                 phone:req.body.phone,
//                 filiere:req.body.filiere,
//                 classe:req.body.classe,
//                 role:"etudiant",
//                 photo:{
//                     data:req.file.filename,
//                     contentType:'image/png'
//                 }

//             })

//         console.log(register);

//         register.save(randomPassword)
//         .then(response=>{
//             res.json({
//                 status:true,
//                 message:"etudiant ajoutée avec succée",
//                 password:randomPassword
//             })
//         })
//         .catch(err=>{
//             throw err
//         })
//         })

        
//         //  register = userModel({
//         //     nomComplet:"hou mbarek",
//         //     cin:"888888",
//         //     numInsc:"77777777",
//         //     email:"ihebmbarek02@gmail.com",
//         //     phone:"44778878455",
//         //     photo:"",
//         //     filiere:"PIINFO",
//         //     classe:"TD1",
//         //     role:"etudiant"
//         // })
//         // let idDel = etudiant._id;
        
//         const randomPassword = generateRandomPassword(12);
        
        
//         //  etudiant.save()
//         // .then(response=>{
//         //     register.save()
//         //     .then(resp=>{
//         //         res.json({
//         //             status:true,
//         //             message:"Etudiant added succeffuly"
//         //         })
//         //     })
//         //     .catch(err=>{
//         //         console.log(err);
//         //         console.log(register);
//         //         console.log(etudiant);
//         //         etudiant.deleteOne({ _id: idDel });
//         //         throw err
//         //         res.json({
//         //             status: false,
//         //             message: "An error occurred. No data saved in either table."
//         //         });
//         //     })
//         // })
//         // .catch(error =>{
//         //     console.log(error);
//         //     res.json({
//         //         status:false,
//         //         message:"An error Occured!"
//         //     })
//         // })
//         // console.log(etudiant);

//         // register.save()
//         // .then(response=>{
//         //     res.json({
//         //         status:true,
//         //         message:"Etudiant added succeffuly"
//         //     })
//         // })
//         // .catch(error =>{
//         //     res.json({
//         //         status:false,
//         //         message:"An error Occured!"
//         //     })
//         // })
//     }catch(err){
//         throw err
//     }

// }

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

const getEtudiants=async(req,res,next)=>{
    try{

        let etudiantList = await userModel.find({role:"etudiant"});

        console.log(etudiantList);

        res.json({status:true,success:etudiantList});

    }catch(err){
        throw err
    }
}

const deleteEtudiant = async (req,res,next)=>{
    try {
        let {id} =req.body;
        console.log(req.body._id);
        let deleted = await userModel.findByIdAndDelete({_id:id});

        res.json({status:true,success:deleted,message:"Deleted"});

    } catch (error) {
        next(error)
    }
}

const editEtudiant =async (req,res,next)=>{
    try{
        let id = req.body._id;
        let register = userModel({
            _id:id,
            nomComplet:req.body.nomComplet,
            cin:req.body.cin,
            numInsc:req.body.numInsc,
            email:req.body.email,
            phone:req.body.phone,
            photo:req.body.photo,
            filiere:req.body.filiere,
            classe:req.body.classe,
            role:"etudiant"
        })
        console.log(id);
        console.log(register);

    const updatedEtudiant = await userModel.findByIdAndUpdate(
        id,
        {$set:register},
        {new:true}
    );


    if (!updatedEtudiant) {
        console.log('No document found with the provided _id.');
        res.json({
            status:false,
            message:"No document found with the provided _id"
        })
      } else {
        console.log('Updated Etudiant:', updatedEtudiant);

        // await userModel.findByIdAndUpdate(
        //     id,
        //     {$set:register},
        //     {new:true}
        // ).then(()=>{
        //     res.json({
        //         status:true,
        //         message:`updated Etudiant: ${updatedEtudiant}`,
        //     })
        // })
        res.json({
            status:true,
            message:"Etudiant modifiée avec succée"
        })
        
      }
    }catch(err){
        throw err
    }

}

module.exports ={
    addEtudiant,getEtudiants,deleteEtudiant,editEtudiant,addEtudiantnew
}