

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constante/config.dart';
import 'package:frontend/controllers/etudiantController.dart';
import 'package:frontend/models/EnseignantModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EnseignantController  extends GetxController{

  TextEditingController nomCompletController = TextEditingController();
  TextEditingController cinController = TextEditingController();
  TextEditingController titreController = TextEditingController();
  TextEditingController numInscController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  EtudiantController etudiantController = Get.put(EtudiantController());

  RxString enseignantPhoto = "".obs;
  RxString cv = "".obs;

  RxString titre="choisir un titre".obs;
  List<String> listTitre=[
    "Professeur",
    "maitre de conferance",
    "maitre Assitant",
    "Assistant",
    "contratuel",
    "vacataire",
    "Proffeseur Agriger",
    "professeur d'enseignement secondaire",
  ];

  var enseignantList = [].obs;
  RxBool valid = true.obs;


  ////////////////////////crud operations///////////////////////////////////

  Future<void> addEnseignant()async {
    var etudiant = EnseignantModel(
        nomComplet: nomCompletController.text,
        cin: cinController.text,
        numInsc: numInscController.text,
        email: emailController.text,
        photo: enseignantPhoto.value,
        phone: phoneController.text,
        cv: cv.value,
        titre: titre.value
    );
    
    var response =  await http.post(Uri.parse(storeEnseignant),
        headers: {"Content-type":"application/json"},
        body: jsonEncode(etudiant.toJson()));
    print(response.body);

    var jsonResponse = jsonDecode(response.body);

    if(jsonResponse["status"]){
      etudiantController.sendEmail(jsonResponse["password"],emailController.text);
      Get.back();

    }
    else{
      print("something went wrong");
    }
  }

  Future<void> getEnseignants(BuildContext context)async{
    try{  
      valid.value=false;
      print("iniiinnnnnnnnnnn");

      var response =  await http.get(Uri.parse(listEnseignants));
      print(response);

      var jsonResponse =  jsonDecode(response.body);

      if(jsonResponse['status']){
        enseignantList.value =jsonResponse['success'];
        valid.value=true;
      }else{
        valid.value=true;
        print('something went wrong');
        ScaffoldMessenger.of( context).showSnackBar(
            SnackBar(
                content:Container(
                  height: 90,
                  decoration: BoxDecoration(color: Color(0xFFC72C41)),
                  child: Text('Erreur de recupération des donées'),
                )
            )
        );
      }
    }catch(e){
      valid.value=true;
      print(e);
      print('////////////////////////');
      ScaffoldMessenger.of( context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.blue,
              content:Text('Erreur de recupération des donées',style: TextStyle(color: Colors.white),)
          )
      );

    }


  }


////////////////////////crud operations///////////////////////////////////

}