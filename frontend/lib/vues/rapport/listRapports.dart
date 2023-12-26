import 'package:flutter/material.dart';
import 'package:frontend/controllers/rapportController.dart';
import 'package:frontend/vues/rapport/rapportDetails.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ListRapport extends StatefulWidget {
  const ListRapport({Key? key}) : super(key: key);

  @override
  State<ListRapport> createState() => _ListRapportState();
}

class _ListRapportState extends State<ListRapport> {
  RapportController rapportController = Get.put(RapportController());

  @override
  Widget build(BuildContext context) {
    return Obx(
        ()=>Container(
          child: Center(
          child: rapportController.valid.value == true
              ?RefreshIndicator(
            onRefresh: ()async{
              rapportController.getRapports(context);
              },
                child: ListView.builder(
                itemCount: rapportController.listeDeRapports.length,
                itemBuilder: (context,i){
                  return ListTile(
                    onTap: (){
                      // showDialog(
                      //     context: context,
                      //     builder: (BuildContext context){
                      //       selectedStatus = rapportController.listeDeRapports[i].status;
                      //       return AlertDialog(
                      //         content: Container(
                      //           height: MediaQuery.sizeOf(context).height*0.5,
                      //           child: Column(
                      //             mainAxisAlignment: MainAxisAlignment.start,
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: [
                      //               Text('Type De Rapoport:',
                      //                 softWrap: false,
                      //                 style: TextStyle(
                      //               color: Colors.lightBlueAccent,
                      //               fontSize: 20
                      //           ),
                      //               ),
                      //               SizedBox(height: 10,),
                      //               Text(
                      //                   rapportController.listeDeRapports[i].rapportType!,
                      //                 style: TextStyle(
                      //                     fontSize: 18
                      //                 ),
                      //               ),
                      //               SizedBox(height: 20,),
                      //               Text("Contenu de rapport",
                      //                 style: TextStyle(
                      //                   color: Colors.lightBlueAccent,
                      //                   fontSize: 20
                      //               ),),
                      //               SizedBox(height: 20,),
                      //               Text(rapportController.listeDeRapports[i].rapportContent!,
                      //                 style: TextStyle(
                      //                   fontSize: 18
                      //               ),),
                      //               SizedBox(height: 20,),
                      //               Text('status de rapport',
                      //                   style: TextStyle(
                      //                   color: Colors.lightBlueAccent,
                      //                   fontSize: 20
                      //               )),
                      //               SizedBox(height: 20,),
                      //               // Text(rapportController.listeDeRapports[i].status!),
                      //               // Obx(()=>
                      //                   Row(
                      //                 // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //                 crossAxisAlignment: CrossAxisAlignment.center,
                      //                 children: [
                      //                   Icon(Icons.list,color: Colors.blue,size: 25,),
                      //                   SizedBox(width: MediaQuery.sizeOf(context).width*0.03,),
                      //                   DropdownButton(
                      //                     hint:Text(selectedStatus!,),
                      //                     underline: SizedBox(),
                      //                     icon: SizedBox(),
                      //
                      //                     items: items!.map((String items) {
                      //                       return DropdownMenuItem(
                      //                         value: items,
                      //                         child: Text(items,style: TextStyle(color: Colors.grey),),
                      //                       );
                      //                     }).toList(),
                      //                     onChanged: (String? newValue) {
                      //                       setState(() {
                      //                         selectedStatus = newValue!;
                      //                       });
                      //                       print(selectedStatus);
                      //                     },
                      //                   ),
                      //                 ],
                      //               ),
                      //               SizedBox(height: 20,),
                      //               Center(
                      //                 child: GestureDetector(
                      //                   child: Container(
                      //                     child: Text("Update"),
                      //                   ),
                      //                 ),
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      //       );
                      //     }
                      // );
                      Get.to(()=>RapportDetailsPage(rapport: rapportController.listeDeRapports[i],));
                      print(rapportController.listeDeRapports[i]);
                    },
                    // title: Text(rapportController.listeDeRapports[i].rapportType!),
                    title: Text(
                      rapportController.listeDeRapports[i].rapportContent!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    subtitle: Text(rapportController.listeDeRapports[i].status!),
                  );
                }
          ),
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
                        SizedBox(width: 30,),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: MediaQuery.sizeOf(context).height*0.02,
                              width: MediaQuery.sizeOf(context).width*0.75,
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
    );
  }
}
