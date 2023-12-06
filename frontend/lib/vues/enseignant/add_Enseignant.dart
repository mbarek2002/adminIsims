
import 'package:flutter/material.dart';
import 'package:frontend/controllers/enseignantController.dart';
import 'package:frontend/controllers/etudiantController.dart';
import 'package:frontend/vues/etudiant/InputField.dart';
import 'package:frontend/vues/etudiant/dropDownButton.dart';
import 'package:get/get.dart';


class AddEnseignantPage extends StatelessWidget {
   AddEnseignantPage({Key? key}) : super(key: key);
  EtudiantController etudiantController  = Get.put(EtudiantController());

  EnseignantController enseignantController = Get.put(EnseignantController());


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
        title:Text('Ajouter Un Enseignant',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
      ),
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        child:
        Obx(
              ()=>
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
                  // Text('Create An Account Enseignant',style: TextStyle(color: Colors.blue.withOpacity(0.8),fontWeight: FontWeight.bold,fontSize: 20),)
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
                  InputField(title: "Nom Complet",hintText: "Nom Complet d'etudiant",icon:Icons.person_outline,controller: enseignantController.nomCompletController,),
                  SizedBox(height: MediaQuery.sizeOf(context).height*0.03,),
                  InputField(title: "CIN",hintText: "cin d'utlisateur",icon:Icons.person_outline,controller: enseignantController.cinController,keyboardType: TextInputType.number),
                  SizedBox(height: MediaQuery.sizeOf(context).height*0.03,),
                  InputField(title: "Num Inscription",hintText: "Num Inscription d'utlisateur",icon:Icons.person_outline,controller: enseignantController.numInscController,keyboardType: TextInputType.number,),
                  SizedBox(height: MediaQuery.sizeOf(context).height*0.03,),
                  InputField(title: "Address Email",hintText: 'Entrer Address Email',icon:Icons.mail_outline_rounded,controller: enseignantController.emailController,),
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
                  InputField(title: "Phone",hintText: 'Enter Phone Number',icon:Icons.phone_outlined,controller: enseignantController.phoneController,keyboardType: TextInputType.number),
                  SizedBox(height: MediaQuery.sizeOf(context).height*0.03 ,),
                  // DropDownMenuWidget(items: etudiantController.listFiliere,dropdownvalue: etudiantController.filiere.value,titre:"Filiére"),
                  // SizedBox(height: MediaQuery.sizeOf(context).height*0.03 ,),
                  // DropDownMenuWidget(items: etudiantController.listClasse,dropdownvalue: etudiantController.classe.value,titre:"classe"),
                  DropDownMenuWidget(items: enseignantController.listTitre,dropdownvalue: enseignantController.titre.value,titre:"Titre"),
                  SizedBox(height: MediaQuery.sizeOf(context).height*0.03 ,),
                  Padding(
            padding:  EdgeInsets.only(left: MediaQuery.sizeOf(context).width*0.04),
            child:
            // Obx(()=>
              Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("CV"!,
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
                        Icon(Icons.file_download_rounded,color: Colors.blue,size: 25,),
                        SizedBox(width: MediaQuery.sizeOf(context).width*0.03,),
                        Text('choisir un fichier ')
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
                          enseignantController.addEnseignant();
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

