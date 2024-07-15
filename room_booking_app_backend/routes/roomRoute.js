const express = require('express');
const router = express.Router();
const roomController = require('../controller/roomController');
const userController = require('../controller/userController');

//post
router.post('/book-a-room', userController.verifyUser, roomController.bookRoom);

//get
router.get('/view-bookings', userController.verifyUser, roomController.viewBookings);


module.exports = router;