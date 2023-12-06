const express = require('express');
const router = express.Router();
const multer = require('multer');

const Storage = multer.diskStorage({
  destination:'uploads',
  filename:(req,file,cb)=>{
      cb(null,file.originalname);
      console.log(file);
      console.log(req.body);
  }
})

const upload = multer({
  storage:Storage
}).single('photo')

const etudiantController = require('../controllers/etudiant.controller');

router.post('/storeEtudiant', upload, etudiantController.addEtudiantnew);
router.get('/getEtudiants',etudiantController.getEtudiants);
router.post('/deleteEtudiant',etudiantController.deleteEtudiant);
router.post('/editEtudiant',etudiantController.editEtudiant)


module.exports = router;