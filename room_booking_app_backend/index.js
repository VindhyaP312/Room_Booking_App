const express = require('express');
const db = require('./config/db');   //connecting mongo-db
require('dotenv').config();
const roomRoutes = require('./routes/roomRoute');
const userRoutes = require('./routes/userRoute');
const cors = require('cors');

const app = express();

app.use(cors());  

app.use(express.json()); // similar to body-parser middleware,built-in middleware for JSON parsing

const PORT  = process.env.PORT || 3000;

app.use('/user',userRoutes)
app.use('/room-booking',roomRoutes)

app.listen(PORT,()=>{
    console.log(`Connected to server at ${PORT}`);
});
