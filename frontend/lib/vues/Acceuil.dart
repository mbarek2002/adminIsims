import 'package:flutter/material.dart';
import 'package:frontend/controllers/enseignantController.dart';
import 'package:frontend/controllers/etudiantController.dart';
import 'package:frontend/controllers/rapportController.dart';
import 'package:frontend/vues/enseignant/add_Enseignant.dart';
import 'package:frontend/vues/etudiant/ListEnseigEtud.dart';
import 'package:frontend/vues/etudiant/add_Etudiant.dart';
import 'package:frontend/vues/rapport/rapportDetails.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shimmer/shimmer.dart';


class ListEtudiant extends StatefulWidget {
  const ListEtudiant({Key? key}) : super(key: key);

  @override
  State<ListEtudiant> createState() => _ListEtudiantState();
}

class _ListEtudiantState extends State<ListEtudiant> {
  EtudiantController etudiantController = Get.put(EtudiantController());
  EnseignantController enseignantController = Get.put(EnseignantController());

  int _currentIndex = 0;
  late PageController _pageController;



  @override
  void initState() {
    // TODO: implement initState
    etudiantController.etudiantList!.value=[];
    enseignantController.enseignantList!.value=[];
    etudiantController.getEtudiants(context);
    enseignantController.getEnseignants(context);
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  RapportController rapportController = Get.put(RapportController());

  String? selectedStatus;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton:_currentIndex==0? FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: (){
          Get.to(()=>etudiantController.selectedList.value==1?AddEtudiantPage():AddEnseignantPage());
        },
        child: Icon(Icons.add,color: Colors.white,),
      ):null,
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body:
      PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          ListEnseigEtudPage(),
          Container(
            child: Center(
            child: rapportController.valid.value == true
            ?ListView.builder(
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
                  },
                  title: Text(rapportController.listeDeRapports[i].rapportType!),
                  subtitle: Text(
                      rapportController.listeDeRapports[i].rapportContent!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                );
                }
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
          Container(
          // Your third page content
          color: Colors.orange,
            child: Center(
              child: Text('Page 3'),
          ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.lightBlueAccent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 20),
          child: GNav(
            backgroundColor: Colors.lightBlueAccent,
            color: Colors.white,
            activeColor: Colors.blue,
            tabBackgroundColor: Colors.white,
            gap: 20,
            padding: EdgeInsets.all(13),
            selectedIndex: _currentIndex,
            onTabChange: (index){
              print(index);
              setState(() {
                _currentIndex=index;
                print(_currentIndex);
                _pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                );
                });
              },

            tabs: [
              GButton(icon: Icons.list,text: "list des donnée",),
              GButton(icon: Icons.notification_important_outlined,text: "list reclmation",),
              GButton(icon: Icons.list,text: "list des classes",),
            ],
          ),
        ),
      ),

    );
  }
}