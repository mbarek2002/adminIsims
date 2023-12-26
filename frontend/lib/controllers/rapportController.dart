
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/constante/config.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/models/RapportModel.dart';
import 'package:get/get.dart';

class RapportController extends GetxController{

  RxBool valid = true.obs;
  var items=[
    "n'est pas traité",
    "en cour de traitement",
    "traité"
  ].obs;

  List<RapportModel> listeDeRapports = <RapportModel>[].obs;

  RxList<dynamic> dynamicItems = <dynamic>[].obs;

  Future<void> getRapports(BuildContext context)async {
    try{
      valid.value=false;

      var response =  await http.get(Uri.parse(listRapports));
      var jsonResponse =  jsonDecode(response.body);

      if(jsonResponse['status']){
        dynamicItems.assignAll(jsonResponse['success']);
        print(dynamicItems.length);
        print(dynamicItems);
        listeDeRapports =   dynamicItems.map((item) => RapportModel.fromMap(item)).toList();
        valid.value=true;
        print(listeDeRapports.length);
      }else{
        valid.value=true;
        print('something went wrong');
        ScaffoldMessenger.of(context).showSnackBar(
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
      print(e.toString());
    }
  }

  Future<void> updateRapport(id,selectedItem,BuildContext context)async{

    try {
      print(selectedItem);
      final response =
      await http.post(Uri.parse(editRapport),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            '_id': id,
            "status":selectedItem
          }));
        print(json.encode({
        '_id': id,
        "status":selectedItem
      }));

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.blue,
            content: Text("Status edited successfully")));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to edit Status'),
        ));
      }
    } catch (e) {
      print(e);
    }

  }
}