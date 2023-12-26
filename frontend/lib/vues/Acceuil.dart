import 'package:flutter/material.dart';
import 'package:frontend/controllers/enseignantController.dart';
import 'package:frontend/controllers/etudiantController.dart';
import 'package:frontend/controllers/rapportController.dart';
import 'package:frontend/vues/enseignant/add_Enseignant.dart';
import 'package:frontend/vues/etudiant/ListEnseigEtud.dart';
import 'package:frontend/vues/etudiant/add_Etudiant.dart';
import 'package:frontend/vues/rapport/listRapports.dart';
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
    rapportController.getRapports(context);
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
        actions: [
          if(_currentIndex==0)
          IconButton(
          onPressed: (){
            if(etudiantController.selectedList==1)
              etudiantController.importFromExcel(context);
            else
              enseignantController.importFromExcel(context);
          },
              icon: Icon(Icons.file_upload_outlined,color: Colors.white,size: 35,)
          )
        ],
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
          ListRapport(),
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
              setState(() {
                _currentIndex=index;
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