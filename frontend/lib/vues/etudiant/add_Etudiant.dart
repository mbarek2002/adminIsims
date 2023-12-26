
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controllers/etudiantController.dart';
import 'package:frontend/models/EtudiantModel.dart';
import 'package:frontend/vues/etudiant/InputField.dart';
import 'package:frontend/vues/etudiant/dropDownButton.dart';
import 'package:get/get.dart';

class AddEtudiantPage extends StatefulWidget {
  const AddEtudiantPage({Key? key}) : super(key: key);

  @override
  State<AddEtudiantPage> createState() => _AddEtudiantPageState();
}

class _AddEtudiantPageState extends State<AddEtudiantPage> {


  EtudiantController etudiantController  = Get.put(EtudiantController());


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    etudiantController.nomCompletController.text="";
    etudiantController.cinController.text="";
    etudiantController.numInscController.text="";
    etudiantController.phoneController.text="";
    etudiantController.emailController.text="";
    etudiantController.filiere.value="choisir une filiere";
    etudiantController.classe.value="choisir une classe";
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        title:Text('Ajouter Un Etudiant',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
      ),
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        child:
          Obx(()=>
                ListView(
                  children: [
                    // Container(
                    //   height: 100,
                    //   width: 100,
                    //   decoration: BoxDecoration(
                    //     // image:DecorationImage()
                    //   ),
                    //   child: Image.asset("assets/logo_isms.jpg"),
                    // ),
                    // Center(child:
                    // ),
                    SizedBox(height: MediaQuery.sizeOf(context).height*0.03 ,),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(100),
                    //     color: Colors.red
                    //   ),
                    //   height: MediaQuery.sizeOf(context).height*0.1,
                    //   width: MediaQuery.sizeOf(context).width*0.05,
                    //   // child: Image.asset("assets/person.jpg",fit: BoxFit.cover,),
                    // ),
                    GestureDetector(
                      onTap: (){
                        // showModalBottomSheet(
                        //     context: context,
                        //     builder: (BuildContext context){
                        //       return Container(
                        //         height: 150,
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //           children: [
                        //             GestureDetector(
                        //               onTap:(){
                        //                etudiantController.captureImage(etudiantController.etudiantPhoto.value) ;
                        //               },
                        //               child: Container(
                        //                 width:MediaQuery.sizeOf(context).width*0.3,
                        //                 child: Row(
                        //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //                   children: [
                        //                     Icon(Icons.camera,color: Colors.blue,size: 30,),
                        //                     Text('Camera',style: TextStyle(fontSize: 20,color: Colors.blue),)
                        //                   ],
                        //                 ),
                        //               ),
                        //             ),
                        //             GestureDetector(
                        //               onTap:(){
                        //                 etudiantController.pickFile(etudiantController.etudiantPhoto.value);
                        //               },
                        //               child: Container(
                        //                 width:MediaQuery.sizeOf(context).width*0.3,
                        //                 child: Row(
                        //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //                   children: [
                        //                     Icon(Icons.photo),
                        //                     Text('galery')
                        //                   ],
                        //                 ),
                        //               ),
                        //             )
                        //           ],
                        //         ),
                        //       );
                        //     });
                        etudiantController.pickFile();
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        // backgroundImage: AssetImage("assets/person.jpg"),
                        radius: 50,
                        child: Stack(
                          children: [
                            ClipOval(
                              child:etudiantController.etudiantPhoto.value==""?
                              Image.asset(
                                    "assets/person.jpg",
                                fit: BoxFit.cover,
                              )
                              :Image.file(File(etudiantController.etudiantPhoto.value),
                                fit: BoxFit.cover,
                                ),
                            ),
                            Positioned(
                              bottom: 0,
                                right: 0,
                                child:
                                  Icon(Icons.camera_alt_rounded,
                                  color: Colors.black87)
                            )
                          ],
                        )
                      ),
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).height*0.03,),
                    InputField(title: "Nom Complet",hintText: "Nom Complet d'etudiant",icon:Icons.person_outline,controller: etudiantController.nomCompletController,),
                    SizedBox(height: MediaQuery.sizeOf(context).height*0.03,),
                    InputField(title: "CIN",hintText: "cin d'utlisateur",icon:Icons.person_outline,controller: etudiantController.cinController,keyboardType: TextInputType.number),
                    SizedBox(height: MediaQuery.sizeOf(context).height*0.03,),
                    InputField(title: "Num Inscription",hintText: "Num Inscription d'utlisateur",icon:Icons.person_outline,controller: etudiantController.numInscController,keyboardType: TextInputType.number,),
                    SizedBox(height: MediaQuery.sizeOf(context).height*0.03,),
                    InputField(title: "Address Email",hintText: 'Entrer Address Email',icon:Icons.mail_outline_rounded,controller: etudiantController.emailController,),
                    // SizedBox(height: MediaQuery.sizeOf(context).height*0.03,),
                    // Padding(
                    //   padding:  EdgeInsets.only(left: MediaQuery.sizeOf(context).width*0.04),
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text('Password',
                    //         style: TextStyle(
                    //           color: Colors.blue,
                    //           fontSize: 15,),),
                    //       SizedBox(height: MediaQuery.sizeOf(context).height*0.01,),
                    //       Container(
                    //           width: MediaQuery.sizeOf(context).width*0.9,
                    //           height: MediaQuery.sizeOf(context).height*0.08,
                    //           decoration: BoxDecoration(
                    //             border: Border.all(
                    //               color: Colors.grey,
                    //               width: 1.0,
                    //             ),
                    //             borderRadius: BorderRadius.circular(8.0),
                    //           ),
                    //           child: TextFormField(
                    //             controller: etudiantController.passwordController,
                    //             obscureText: etudiantController.obscureText.value,
                    //             decoration: InputDecoration(
                    //               prefixIcon: Icon(Icons.lock_outlined,color: Colors.blue,),
                    //               hintText: 'Enter Password',
                    //               hintStyle: TextStyle(
                    //                   color: Colors.grey
                    //               ),
                    //               border: InputBorder.none,
                    //               contentPadding: EdgeInsets.all(16.0),
                    //               suffixIcon: GestureDetector(
                    //                 onTap: (){
                    //                     etudiantController.obscureText.value = !etudiantController.obscureText.value;
                    //                 },
                    //                 child: etudiantController.obscureText.value ?
                    //                 const Icon(Icons.visibility_off,color: Colors.blue,):
                    //                 const Icon(Icons.visibility,color: Colors.blue,),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(height: MediaQuery.sizeOf(context).height*0.03,),
                    InputField(title: "Phone",hintText: 'Enter Phone Number',icon:Icons.phone_outlined,controller: etudiantController.phoneController,keyboardType: TextInputType.number),
                    SizedBox(height: MediaQuery.sizeOf(context).height*0.03 ,),
                    // DropDownMenuWidget(items: etudiantController.listFiliere,dropdownvalue: etudiantController.filiere.value,titre:"Filiére"),
                    Padding(
                      padding:  EdgeInsets.only(left: MediaQuery.sizeOf(context).width*0.04),
                      child:
                      // Obx(()=>
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Filiére",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 15,),),
                          SizedBox(height: MediaQuery.sizeOf(context).height*0.01,),
                          Container(
                            width: MediaQuery.sizeOf(context).width*0.9,
                            height: MediaQuery.sizeOf(context).height*0.08,
                            // color: Colors.red,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Padding(
                              padding:  EdgeInsets.only(left:MediaQuery.sizeOf(context).width*0.02),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.list,color: Colors.blue,size: 25,),
                                  SizedBox(width: MediaQuery.sizeOf(context).width*0.03,),
                                  DropdownButton(
                                    hint:Text(etudiantController.filiere.value),
                                    underline: SizedBox(),
                                    icon: SizedBox(),

                                    items: etudiantController.listFiliere.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items,style: TextStyle(color: Colors.grey),),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      etudiantController.filiere.value = newValue!;
                                      print(etudiantController.filiere.value);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    // )
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).height*0.03 ,),
                    // DropDownMenuWidget(items: etudiantController.listClasse,dropdownvalue: etudiantController.classe.value,titre:"classe"),
                    Padding(
                        padding:  EdgeInsets.only(left: MediaQuery.sizeOf(context).width*0.04),
                        child:
                        // Obx(()=>
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("classe",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 15,),),
                                SizedBox(height: MediaQuery.sizeOf(context).height*0.01,),
                                Container(
                                  width: MediaQuery.sizeOf(context).width*0.9,
                                  height: MediaQuery.sizeOf(context).height*0.08,
                                  // color: Colors.red,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Padding(
                                    padding:  EdgeInsets.only(left:MediaQuery.sizeOf(context).width*0.02),
                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.list,color: Colors.blue,size: 25,),
                                        SizedBox(width: MediaQuery.sizeOf(context).width*0.03,),
                                        DropdownButton(
                                          hint:Text(etudiantController.classe.value),
                                          underline: SizedBox(),
                                          icon: SizedBox(),

                                          items: etudiantController.listClasse.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(items,style: TextStyle(color: Colors.grey),),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            etudiantController.classe.value = newValue!;
                                            print(etudiantController.classe.value);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        // )
                    ),

                    SizedBox(height: MediaQuery.sizeOf(context).height*0.03 ,),

                    Center(
                      child: Container(
                        height: MediaQuery.sizeOf(context).height*0.06,
                        width: MediaQuery.sizeOf(context).width*0.9,
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.5),
                          borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: TextButton(
                          onPressed: (){
                            print(etudiantController.nomCompletController.text);
                            print(etudiantController.cinController.text);
                            print(etudiantController.numInscController.text);
                            print(etudiantController.emailController.text);
                            print(etudiantController.phoneController.text);
                            print(etudiantController.filiere.value);
                            print(etudiantController.classe.value);
                            print(etudiantController.etudiantPhoto);
                            etudiantController.addEtudiant();

                            print(etudiantController.EtudiantList);
                            Get.back();
                            // etudiantController.EtudiantList.add(EtudiantModel(
                            //     nomComplet: etudiantController.nomCompletController.text,
                            //     cin: etudiantController.cinController.text,
                            //     classe: etudiantController.classe.value,
                            //     numInsc: etudiantController.numInscController.text,
                            //     email: etudiantController.emailController.text,
                            //     filiere: etudiantController.filiere.value,
                            //     photo: etudiantController.etudiantPhoto.value,
                            //     phone: etudiantController.phoneController.text
                            // ));
                          },
                          child: Text('Add',style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).height*0.03 ,),
                  ],
                ),
        ),

      ),
    );
  }
}

