import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/controllers/etudiantController.dart';
import 'package:frontend/models/EtudiantModel.dart';
import 'package:frontend/vues/etudiant/InputField.dart';
import 'package:frontend/vues/etudiant/dropDownButton.dart';
import 'package:get/get.dart';

class EditEtudiant extends StatefulWidget {
   EditEtudiant({
    Key? key,
    this.etudiant
  }) : super(key: key);

  EtudiantModel? etudiant;

  @override
  State<EditEtudiant> createState() => _EditEtudiantState();
}

class _EditEtudiantState extends State<EditEtudiant> {
  EtudiantController etudiantController  = Get.put(EtudiantController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    etudiantController.nomCompletController.text=widget.etudiant!.nomComplet!;
    etudiantController.cinController.text=widget.etudiant!.cin!;
    etudiantController.numInscController.text=widget.etudiant!.numInsc!;
    etudiantController.emailController.text=widget.etudiant!.email!;
    etudiantController.phoneController.text=widget.etudiant!.phone!;
    etudiantController.filiere.value=widget.etudiant!.filiere!;
    etudiantController.classe.value=widget.etudiant!.classe!;

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Edit Student',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        child: Obx(
              ()=>ListView(
                  children: [
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
                    CircleAvatar(
                        backgroundColor: Colors.white,
                        // backgroundImage: AssetImage("assets/person.jpg"),
                        radius: 50,
                        child: Stack(
                          children: [
                            ClipOval(
                              child: Image.asset(
                                "assets/person.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                                bottom: -15,
                                right: -10,
                                child: IconButton(
                                  icon:Icon(Icons.camera_alt_rounded,
                                      color: Colors.black87),
                                  onPressed: (){
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context){
                                          return Container(
                                            height: 150,

                                          );
                                        });
                                  },
                                ))
                          ],
                        )
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
                    DropDownMenuWidget(items: etudiantController.listFiliere,dropdownvalue: etudiantController.filiere.value,titre:"Filiére"),
                    SizedBox(height: MediaQuery.sizeOf(context).height*0.03 ,),
                    DropDownMenuWidget(items: etudiantController.listClasse,dropdownvalue: etudiantController.classe.value,titre:"classe"),
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
                            print(json.encode({
                              'nomComplet': etudiantController.nomCompletController.text,
                              "cin":etudiantController.cinController.text,
                              "classe":etudiantController.classe.value,
                              "photo":"photo",
                              "numInsc":etudiantController.numInscController.text,
                              "phone":etudiantController.phoneController.text,
                              'email': etudiantController.emailController.text,
                              "filiere":etudiantController.filiere.value
                            }));
                            etudiantController.editEtudiant(widget.etudiant!.id,context).then((value) => Get.back());
                          },
                          child: Text('Edit',style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    )
            ],
          )
        ),
      ),
    );
  }
}
