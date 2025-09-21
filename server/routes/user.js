const express = require('express');
const router = express.Router();
const verifyFirebaseToken = require('../middleware/firebaseAuth');
const { createUser, getUser } = require('../controllers/userController');
const { getPizzas } = require('../controllers/pizzaController');
const { addfav,getfavs, removefav } = require('../controllers/favController');


router.post('/user', verifyFirebaseToken, createUser);
router.get('/user', verifyFirebaseToken, getUser);
router.get('/pizza', verifyFirebaseToken, getPizzas );
router.post('/favourite',verifyFirebaseToken,addfav);
router.get('/favourite',verifyFirebaseToken,getfavs);
router.delete('/favourite',verifyFirebaseToken,removefav);

module.exports = router;