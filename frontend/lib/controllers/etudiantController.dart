import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/EtudiantModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/constante/config.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_excel/excel.dart';

import 'package:file_picker/file_picker.dart';
import 'package:frontend/models/EtudiantModel.dart';
class EtudiantController extends GetxController {
  TextEditingController nomCompletController = TextEditingController();
  TextEditingController cinController = TextEditingController();
  TextEditingController numInscController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  var obscureText = true.obs;
  RxBool valid = true.obs;

  RxInt selectedList = 1.obs;

  var etudiantList = [].obs;

  List<String> listFiliere = [
    "P-LSI",
    "D-LSI",
    "P-CPI",
    "D-CPI",
    "T-MM",
    "T-BIG",
    "P-IINFO",
    "D-IINFO",
    "T-IITWM",
    "P-IITWM",
  ];

  List<String> listClasse = [
    "TD1",
    "TD2",
  ];

  RxString filiere = "choisir une filiere".obs;
  RxString classe = "choisir un classe".obs;

////////////////////////emailjs////////////////////////:

  // void sendEmail(String password) async {
  //   try {
  //     await EmailJS.send(
  //       'service_i5wml4p',
  //       'template_ha7mfhj',
  //       {
  //         'user_email': 'ihebmbarek02@gmail.com',
  //         'message': 'password'+password,
  //       },
  //       const Options(
  //         publicKey: 'Ac-DXUZZLpb-tsDbN',
  //         privateKey: 'L_smJSr9z3Wjus8O97xpW',
  //       ),
  //     );
  //     // await http.post(Uri.parse('https://your-server-endpoint.com/send-email'), body: {'password': password});
  //
  //     print('SUCCESS!');
  //   } catch (error) {
  //     if (error is EmailJSResponseStatus) {
  //       print('ERROR... ${error.status}: ${error.text}');
  //     }
  //     print(error.toString());
  //   }
  // }

  // Future<void> sendEmailToParents() async{
  //   print('send email to parents :))');
  //   final serviceId='service_i5wml4p';
  //   final templateId='template_ha7mfhj';
  //   // final userId='SaGQJusVSIxIMGhiw';
  //   // print(userId);
  //   final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  //   final response=await http.post(
  //       url,
  //       headers:{
  //         'ContentType': 'application/json',
  //         'origin': 'http://localhost'
  //       },
  //       body: json.encode({
  //         'service_id': serviceId,
  //         'template_id': templateId,
  //         'user_id': "Ac-DXUZZLpb-tsDbN",
  //         'template_params': {
  //           // 'lost_child_name': _name,
  //           // 'user_name':_username,
  //           // 'user_contact_number':_user_contact_number,
  //           // 'user_email':widget.email,
  //           // 'location':_location,
  //           // 'police_address':_registered_lost_at,
  //           // "parent's_email":_parent_email,
  //           // "child_img_url": image1
  //
  //           "to_name":"iheb ",
  //           "from_name":"hsdkhfodshf",
  //           "message":"hiiii"
  //
  //         },
  //       })
  //   );
  //
  //   print(response.body);
  // }

////////////////////crud operation///////////////////////////////////////

  //////////////////////

  Future<void> sendEmail(String password,String email) async {
    var data = {
      'service_id': 'service_i5wml4p',
      'template_id': 'template_ha7mfhj',
      'user_id': 'Ac-DXUZZLpb-tsDbN',
      'template_params': {
        'to': email,
        'from_name': 'iheb',
        'message': "your a account name :"+email+
            "\nyour password is :"+password
      },
    };

    final response = await http.post(
      Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
      headers: {'Content-Type': 'application/json', 'origin': 'http://localhost'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      // Request successful
      print('Your mail is sent!');
      // You can perform any action here upon successful sending
    } else {
      // Request failed
      print('Oops... ${jsonDecode(response.body)}');
      // You can handle the error or show an alert dialog
    }
  }
  //////////////////////

  Future<void> addEtudiant() async {
    var etudiant = EtudiantModel(
        nomComplet: nomCompletController.text,
        cin: cinController.text,
        classe: classe.value,
        numInsc: numInscController.text,
        email: emailController.text,
        filiere: filiere.value,
        photo: etudiantPhoto.value,
        phone: phoneController.text
    );

    var response = await http.post(Uri.parse(storeEtud),
        headers: {"Content-type": "application/json"},
        body: jsonEncode(etudiant.toJson()));

    // if (etudiantPhoto == null) {
    //   // No file selected
    //   return;
    // }
    //
    // final url = Uri.parse('http://192.168.1.11:3000/etudiant/upload');
    // final request = http.MultipartRequest('POST', url)
    //   ..files.add(
    //     await http.MultipartFile.fromPath('file', etudiantPhoto.value),
    //   )
    //   ..fields['nomComplet'] = nomCompletController.text
    //   ..fields['cin'] = cinController.text
    //   ..fields['classe'] = classe.value
    //   ..fields['numInsc'] = numInscController.text
    //   ..fields['email'] = emailController.text
    //   ..fields['filiere'] = filiere.value
    //   ..fields['phone'] = phoneController.text;
    //
    // try {
    //   final response = await request.send();
    //   if (response.statusCode == 201) {
    //     print('File uploaded successfully!');
    //   } else {
    //     print('Failed to upload file. Status code: ${response.statusCode}');
    //   }
    // } catch (error) {
    //   print('Error uploading file: $error');
    // }

    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse["status"]) {
      print(jsonResponse["password"]);
      sendEmail(jsonResponse["password"],emailController.text);
      Get.back();
    } else {
      print("something went wrong");
    }
  }

  Future<void> editEtudiant(id, BuildContext context) async {
    try {
      print(id);
      final response = await http.post(Uri.parse(editEtud),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            '_id': id,
            'nomComplet': nomCompletController.text,
            "cin": cinController.text,
            "classe": classe.value,
            "photo": "photo",
            "numInsc": numInscController.text,
            "phone": phoneController.text,
            'email': emailController.text,
            "filiere": filiere.value
          }));
      print(json.encode({
        '_id': id,
        'nomComplet': nomCompletController.text,
        "cin": cinController.text,
        "classe": classe.value,
        "photo": "photo",
        "numInsc": numInscController.text,
        "phone": phoneController.text,
        'email': emailController.text,
        "filiere": filiere.value
      }));
      print(response.statusCode);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.blue,
            content: Text("Etudiant Data edited successfully")));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to edit Etudiant data'),
        ));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getEtudiants(BuildContext context) async {
    try {
      valid.value = false;

      var response = await http.get(Uri.parse(listEtudiants));
      print(response);

      var jsonResponse = jsonDecode(response.body);

      if (jsonResponse['status']) {
        etudiantList.value = jsonResponse['success'];
        valid.value = true;
      } else {
        valid.value = true;
        print('something went wrong');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Container(
          height: 90,
          decoration: BoxDecoration(color: Color(0xFFC72C41)),
          child: Text('Erreur de recupération des donées'),
        )));
      }
    } catch (e) {
      valid.value = true;
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.blue,
          content: Text(
            'Erreur de recupération des donées',
            style: TextStyle(color: Colors.white),
          )));
    }
  }

  Future<void> deleteEtudiant(id, BuildContext context) async {
    var regbody = {"id": id};

    try {
      var response = await http.post(Uri.parse(deleteEtud),
          headers: {"Content-type": "application/json"},
          body: jsonEncode(regbody));

      var jsonResponse = jsonDecode(response.body);

      if (jsonResponse['status']) {
        print("Etudiant deleted Succefully");
        Navigator.pop(context);
        Get.snackbar(
          "title",
          "Etudiant deleted Succefully",
          colorText: Colors.white,
          backgroundColor: Colors.lightBlue,
          icon: const Icon(Icons.add_alert),
        );
        getEtudiants(context);
      } else {
        print('An error occured');
        Navigator.pop(context);
        Get.snackbar(
          "title",
          "An error occured",
          colorText: Colors.white,
          backgroundColor: Colors.lightBlue,
          icon: const Icon(Icons.add_alert),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

////////////////////end crud operation///////////////////////////////////////

  RxString etudiantPhoto = "".obs;
  RxString enseignantPhoto = "".obs;

  // void pickFile(String path) async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles();
  //
  //   if (result != null) {
  //     PlatformFile file = result.files.first;
  //     print('Path: ${file.path}');
  //     print('Name: ${file.name}');
  //     print('Size: ${file.size}');
  //     path = file.path!;
  //   } else {
  //     print('User canceled the file picking.');
  //   }
  // }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      etudiantPhoto.value = result.files.single.path!;
    }
    print(etudiantPhoto);
  }

  void captureImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      File file = File(pickedFile.path);

      etudiantPhoto.value = file.path!;
    } else {
      print('User canceled the camera capture.');
    }
  }


  String? file;
  RxList<EtudiantModel> EtudiantList = <EtudiantModel>[].obs;


  Future importFromExcel(BuildContext context) async {
    EtudiantList = RxList<EtudiantModel>([]);

    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
      allowMultiple: false,
    );

    file = pickedFile?.files.single.path;
    var bytes = File(file!).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);
    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {

        EtudiantList.add(EtudiantModel(
            nomComplet: row[0]?.value ?? "",
            cin: row[1]?.value.toString() ?? "",
            numInsc: row[2]?.value.toString() ?? "",
            phone: row[3]?.value.toString() ?? "",
            email: row[4]?.value.toString() ?? "",
            filiere: row[5]?.value.toString() ?? "",
            classe: row[6]?.value.toString() ?? "",
            photo: ""
        ));
      }
    }
    EtudiantList.length;
    print(EtudiantList);
    for(int i=0; i<EtudiantList.length;i++){
      try{
        var response =  await http.post(Uri.parse(storeEtud),
            headers: {"Content-type":"application/json"},
            body: jsonEncode(EtudiantList[i].toJson()));
        print(response.body);

        var jsonResponse = jsonDecode(response.body);

        if(jsonResponse["status"]){
          sendEmail(jsonResponse["password"],EtudiantList[i].email!);
          Get.back();
        }

        else{
          print("something went wrong");
        }
      }catch(e){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                backgroundColor: Colors.blue,
                content:Text("Une erreur est survenue lors de la sauvegarde des données.",
                  style: TextStyle(color: Colors.white),)
            )
        );
        print(e);
      }
    }

  }
}

