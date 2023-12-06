const mongoose  = require('mongoose')
const db = require('../config/db')

const {Schema} =mongoose;

const rapportSchema =new Schema({
    id:{
        type:String
    },
    rapportType:{
        type:String
    },
    rapportContent:{
        type:String
    },
    seen:{
        type:Boolean
    },
    rapportStatus:{
        type:String
    },

})



const rapportModel = db.model('rapport',rapportSchema);

module.exports = rapportModel;