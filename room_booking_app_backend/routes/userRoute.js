const express = require('express');
const router = express.Router();
const userController = require('../controller/userController');

//signup post
router.post('/signup',userController.signup);

//login post 
router.post('/login',userController.login);

module.exports = router;