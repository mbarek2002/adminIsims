const express = require('express');
const bodyParser  = require('body-parser');
const morgan = require('morgan');
const EtudiantRoute = require('./routes/etudiant.routes')
const EnseignantRoute = require('./routes/enseignant.routes')
const RapportRoute = require('./routes/rapport.routes')

const multer = require('multer');

const userModel = require('./models/user.model');

const app =express();

// app.use(morgan('dev'));
// app.use(bodyParser.urlencoded({extended:true}));
app.use(bodyParser.json())


app.use('/etudiant/',EtudiantRoute)
app.use('/enseignant/',EnseignantRoute)
app.use('/rapport/',RapportRoute)


// const Storage = multer.diskStorage({
//     destination:'uploads',
//     filename:(req,file,cb)=>{
//         cb(null,file.originalname);
//     }
// })

// const upload = multer({
//     storage:Storage
// }).single('photo')

// function generateRandomPassword(length) {
//     const uppercaseChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
//     const lowercaseChars = 'abcdefghijklmnopqrstuvwxyz';
//     const numericChars = '0123456789';
//     const specialChars = '!@#$%^&*()-_+=<>?';
  
//     const allChars =
//       uppercaseChars + lowercaseChars + numericChars + specialChars;
  
//     let password = '';
  
//     for (let i = 0; i < length; i++) {
//       const randomIndex = Math.floor(Math.random() * allChars.length);
//       password += allChars.charAt(randomIndex);
//     }
//     console.log(password);
//     return password;
//   }


// app.post('/upload',(req,res)=>{
//     try {
//         const randomPassword = generateRandomPassword(12);

//         // Ensure generateRandomPassword returns a password
//         console.log(req.body);
//         console.log(req.file);

//         upload(req, res, (err) => {
//             if (err) {
//                 console.error(err);
//                 return res.status(500).json({
//                     status: false,
//                     message: 'File upload failed',
//                 });
//             }

//             console.log(req.file);

//             const register = new userModel({
//                 nomComplet: req.body.nomComplet,
//                 cin: req.body.cin,
//                 numInsc: req.body.numInsc,
//                 email: req.body.email,
//                 phone: req.body.phone,
//                 filiere: req.body.filiere,
//                 classe: req.body.classe,
//                 role: 'etudiant',
//                 photo: {
//                     data: req.file.filename, 
//                     contentType: req.file.mimetype,
//                 },
//             });

//             register.save(randomPassword)
//                 .then(response => {
//                     res.json({
//                         status: true,
//                         message: 'Etudiant ajoutée avec succès',
//                         password: randomPassword,
//                     });
//                 })
//                 .catch(err => {
//                     console.error(err);
//                     res.status(500).json({
//                         status: false,
//                         message: 'Error saving to database',
//                     });
//                 });
//         });

//     } catch (error) {
//         console.error(error);
//         res.status(500).json({
//             status: false,
//             message: 'Internal Server Error',
//         });
//     }
// })

module.exports = app;