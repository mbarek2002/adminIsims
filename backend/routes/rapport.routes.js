

const express = require('express');
const router = express.Router();

const rapportController = require('../controllers/rapport.controller');


router.get('/getRapports',rapportController.getRapports);
router.post('/updateRapport',rapportController.updateRapport);


module.exports = router;