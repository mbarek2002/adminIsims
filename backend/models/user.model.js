const mongoose  = require('mongoose')
const db = require('../config/db')
const bcrypt = require('bcrypt');
const nodemailer = require('nodemailer');
const emailjs = require('@emailjs/nodejs');


const {Schema}  = mongoose;

const userSchema = new Schema({
    nomComplet:{
        type:String,
    },
    cin:{
        type:String,
        required:true
    },
    photoName:{
      type:String
    },
    numInsc:{
        type:String,
    },
    email:{
        type:String,
    },
    phone:{
        type:String,  
    },
    data:{
      data:Buffer,
      contentType:String
  },
    filiere:{
        type:String,
    },
    classe:{
        type:String
    },
    cv:{
        type:String
    },
    titre:{
        type:String
    },
    password:{
        type:String
    },
    role:{
      type:String
    }


})

// userSchema.pre('save',async function(){
//     try{
//         var user = this;
//         user.motDePasse = 
//     }catch(err){

//     }
// })

userSchema.pre('save',async function(password){
    try {
        var user = this;
        // sendemail(randomPassword,user.email);
        const salt = await(bcrypt.genSalt(10));
        const hashpass  =  await bcrypt.hash(password,salt);
        user.password=hashpass;
      
    } catch (error) {
        throw error;
    }
});

userSchema.methods.comparePassword = async function(motDePasseUser){
    try {
        const isMatch  =  (motDePasseUser==this.motDePasse)
        return isMatch;
    } catch (error) {
        throw error
    }
}


  
  async function sendPasswordEmail(email, password) {
    const transporter = nodemailer.createTransport({
      service: 'gmail',
      port:587,
      secure:false,
      auth: {
        user: 'ihebmbarek05@gmail.com',
        pass: 'iheb mbarek 99360644'
      }
    });
  
    const mailOptions = {
      from: {
        name:"iheb mbarek",
        address:'ihebmbarek05@gmail.com'
      },
      to: email,
      subject: 'Your New Password',
      text: `Your new password is: ${password}`
    };
  
    try {
      const info = await transporter.sendMail(mailOptions);
      console.log('Email sent: ' + info.response);
    } catch (error) {
      console.error('Error sending email:', error);
    }
  }

async function sendemail(password,email){
  (function(){
    emailjs.init("Ac-DXUZZLpb-tsDbN");
  })

  var params ={
    sendername:"iheb mbarek",
    to:email,
    subject:"isims account password",
    replyto:"iheb",
    message:"password: "+password
  }

  var serviceID = "service_i5wml4p";
  var templateID = "template_ha7mfhj";

  emailjs.send(serviceID,templateID,params,{
    publicKey:"Ac-DXUZZLpb-tsDbN",
    privateKey:"L_smJSr9z3Wjus8O97xpW"
  })
  .then(res=>{
    console.log("email sent succefully!")
  })
  .catch(e=>{
    console.log(e);
  }) 
}

const userModel = db.model('user11',userSchema);

module.exports = userModel;