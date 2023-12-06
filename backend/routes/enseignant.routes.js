const express = require('express');
const router = express.Router();

const etudiantController = require('../controllers/etudiant.controller');
const enseignantController = require('../controllers/enseignant.controller');


router.post('/storeEnseignant',enseignantController.addEnseignant);
router.get('/getEnseignants',enseignantController.getEnseignant);
router.post('/deleteEnseignant',etudiantController.deleteEtudiant);
router.post('/editEnseignant',etudiantController.editEtudiant)


module.exports = router;