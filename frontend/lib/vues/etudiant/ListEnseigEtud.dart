
import 'package:flutter/material.dart';
import 'package:frontend/controllers/enseignantController.dart';
import 'package:frontend/controllers/etudiantController.dart';
import 'package:frontend/models/EtudiantModel.dart';
import 'package:frontend/vues/etudiant/edit_Etudiant.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ListEnseigEtudPage extends StatefulWidget {
  const ListEnseigEtudPage({Key? key}) : super(key: key);

  @override
  State<ListEnseigEtudPage> createState() => _ListEnseigEtudPageState();
}

class _ListEnseigEtudPageState extends State<ListEnseigEtudPage> {

  EtudiantController etudiantController = Get.put(EtudiantController());

  EnseignantController enseignantController = Get.put(EnseignantController());

  @override
  Widget build(BuildContext context) {
      return Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: Obx(()=>
            Column(
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height*0.05,
                  decoration:BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: MediaQuery.sizeOf(context).width*0.5,
                        decoration: BoxDecoration(
                          color: etudiantController.selectedList==1?Colors.blue:Colors.white
                        ),
                        child: TextButton(
                          child:Text('Etudiants',style: TextStyle(
                              color:etudiantController.selectedList==1?Colors.white:Colors.blue,
                              fontSize: 20)),
                          onPressed: (){
                            etudiantController.selectedList.value=1;
                            },
                        ),
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width*0.5,
                        decoration: BoxDecoration(
                            color: etudiantController.selectedList==1?Colors.white:Colors.blue
                        ),
                        child: TextButton(
                          child:Text('Enseignants',
                              style: TextStyle(
                                  color:etudiantController.selectedList==1?Colors.blue:Colors.white,
                                  fontSize: 20)),
                          onPressed: (){
                            etudiantController.selectedList.value=2;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.sizeOf(context).height*0.744,
                  width: MediaQuery.sizeOf(context).width,
                  child: RefreshIndicator(
                    onRefresh: () {
                      return  etudiantController.selectedList.value==1
                      ?etudiantController.getEtudiants(context)
                      :enseignantController.getEnseignants(context);

                    },
                    child: etudiantController.valid.value?
                        ListView.builder(
                          itemCount: etudiantController.selectedList.value==1
                              ?etudiantController.etudiantList?.length
                          :enseignantController.enseignantList?.length,
                          itemBuilder: (context,index){
                          return  ListTile(
                          title: Text(
                              etudiantController.selectedList.value==1
                              ?etudiantController.etudiantList![index]['nomComplet']
                                  :enseignantController.enseignantList![index]['nomComplet']
                          ),
                          leading: Text('photo'),
                          subtitle: Text(
                              etudiantController.selectedList.value==1
                                  ?etudiantController.etudiantList![index]['email']
                                  :enseignantController.enseignantList![index]['email']
                          ),
                          onLongPress: ()=>showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  content: Container(
                                    height: 100,
                                    width: MediaQuery.sizeOf(context).width*0.8,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          child: IconButton(
                                            icon: Icon(Icons.edit),
                                            onPressed: (){
                                              Get.to(()=>EditEtudiant(
                                                etudiant:
                                                EtudiantModel(
                                                    id: etudiantController.etudiantList![index]['_id'],
                                                    nomComplet: etudiantController.etudiantList![index]['nomComplet'],
                                                    cin: etudiantController.etudiantList![index]['cin'],
                                                    classe: etudiantController.etudiantList![index]['classe'],
                                                    photo: etudiantController.etudiantList![index]['photo'],
                                                    numInsc: etudiantController.etudiantList![index]['numInsc'],
                                                    email: etudiantController.etudiantList![index]['email'],
                                                    phone: etudiantController.etudiantList![index]['phone'],
                                                    filiere: etudiantController.etudiantList![index]['filiere']
                                                ),
                                              ));
                                            },
                                          ),
                                        ),
                                        Container(
                                          child: IconButton(
                                            icon: Icon(Icons.delete),
                                            onPressed: (){
                                              etudiantController.deleteEtudiant(etudiantController.etudiantList![index]['_id'],context);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                          ),
                        );
                      },

                    )
                        :Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        for(int i =0;i<7;i++)
                          Container(
                            height: MediaQuery.sizeOf(context).height*0.1,
                            width: MediaQuery.sizeOf(context).width*0.94,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey,
                              highlightColor: Colors.white,
                              child:Row(
                                children: [
                                  Container(
                                    height: MediaQuery.sizeOf(context).height*0.06,
                                    width: MediaQuery.sizeOf(context).width*0.13,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(50)
                                    ),
                                  ),
                                  SizedBox(width: 20,),

                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: MediaQuery.sizeOf(context).height*0.02,
                                        width: MediaQuery.sizeOf(context).height*0.25,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.2),
                                          // borderRadius: BorderRadius.circular(50)
                                        ),
                                      ),
                                      Container(
                                        height: MediaQuery.sizeOf(context).height*0.02,
                                        width: MediaQuery.sizeOf(context).height*0.2,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.2),
                                          // borderRadius: BorderRadius.circular(50)
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),

                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
        ),
      );
  }
}
