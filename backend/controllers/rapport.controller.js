const rapportModel = require('../models/rapport.model');


exports.getRapports = async (req,res,next)=>{
    try{
        console.log(req.body.id);
        let rapportList = await rapportModel.find();

        console.log(rapportList);

        res.json({status:true,success:rapportList});

    }catch(err){
        throw err
    }
}

exports.updateRapport = async (req,res,next)=>{
    try{
        let id=req.body._id;
        let rapport = rapportModel({
            _id:id,
            rapportStatus:req.body.status,
        })
        console.log(rapport);

        const updatedRapport = await rapportModel.findByIdAndUpdate(
            id,
            {$set:rapport},
            {new:true}
        );
        console.log(updatedRapport);


        if (!updatedRapport) {
            console.log('No reclamtion found with the provided _id.');
            res.json({
                status:false,
                message:"No reclamation found with the provided _id"
            })
          } else {
            console.log('Updated reclamation:', updatedRapport);
            res.json({
                status:true,
                message:"reclamation modifiée avec succée"
            })
            
          }
        

    }catch(e){
        console.log(e)
        throw e
    }
}


