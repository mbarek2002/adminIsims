const mongoose = require("mongoose");
const Schema = mongoose.Schema;
const bcrypt = require('bcrypt');

const enseignantSchema = new Schema({
    nomComplet:{
        type:String,
    },
    cin:{
        type:String,
        required:true
    },
    email:{
        type:String,
    },
    phone:{
        type:String,
        
    },
    photo:{
        type:String
    },
    cv:{
        type:String
    },
    titre:{
        type:String
    }

},{timestamps:true});

enseignantSchema.pre('save',async function(){
    try {
        var enseignant = this;
        const salt = await(bcrypt.genSalt(10));
        const hashpass  =  await bcrypt.hash(enseignant.cin,salt);
        enseignant.cin=hashpass;
       
    } catch (error) {
        throw error;
    }
});

const Enseignant = mongoose.model('Enseignant',enseignantSchema);

module.exports = Enseignant;