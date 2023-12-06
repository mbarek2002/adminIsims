const mongoose = require("mongoose");
const Schema = mongoose.Schema;
const bcrypt = require('bcrypt');

const etudiantSchema = new Schema({
    nomComplet:{
        type:String,
    },
    cin:{
        type:String,
        required:true
    },
    numInsc:{
        type:String,
        required:true,
    },
    email:{
        type:String,
    },
    phone:{
        type:String,
    },
    photo:{
        data:Buffer,
        content:String
    },
    filiere:{
        type:String,
        required:true
    },
    classe:{
        type:String
    }

},{timestamps:true});

etudiantSchema.pre('save',async function(){
    try {
        var etudiant = this;
        const salt = await(bcrypt.genSalt(10));
        const hashpass  =  await bcrypt.hash(etudiant.numInsc,salt);
        etudiant.numInsc=hashpass;
       
    } catch (error) {
        throw error;
    }
});

const Etudiant = mongoose.model('Etudiant',etudiantSchema);

module.exports = Etudiant;