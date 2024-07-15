const mongoose = require('mongoose')

const roomSchema = new mongoose.Schema({
//roomNumber,purpose,clubName
roomNumber:{
    type:String,
    required:true,
    unique: true
},
purpose:{
    type:String,
    required:true
},
clubName:{
    type:String,
    required:true
},
userId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true
}
});

module.exports = mongoose.model('Room',roomSchema);