const mongoose = require('mongoose')
require('dotenv').config();

const connection = mongoose.connect(process.env.MONGO_URI)
    .then( () => {
        console.log('Connected to Mongo database ')
    })
    .catch( (err) => {
        console.error(`Error connecting to the Mongo database. \n${err}`);
    });
    
module.exports = connection;


