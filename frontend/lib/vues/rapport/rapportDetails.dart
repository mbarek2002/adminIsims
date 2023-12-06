

import 'package:flutter/material.dart';
import 'package:frontend/controllers/rapportController.dart';
import 'package:frontend/models/RapportModel.dart';
import 'package:get/get.dart';

class RapportDetailsPage extends StatefulWidget {
   RapportDetailsPage({
     Key? key,
     this.rapport
   }) : super(key: key);

   RapportModel? rapport;

  @override
  State<RapportDetailsPage> createState() => _RapportDetailsPageState();
}

class _RapportDetailsPageState extends State<RapportDetailsPage> {

  RapportController rapportController =Get.put(RapportController());
  String? selectedItem;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedItem= widget.rapport!.status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        title: Text('Rapport Details',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Type De Rapoport:',
                softWrap: false,
                style: TextStyle(
                    color: Colors.lightBlueAccent,
                    fontSize: 20
                ),
              ),
              SizedBox(height: 10,),
              Text(
                widget.rapport!.rapportType!,
                style: TextStyle(
                    fontSize: 18
                ),
              ),
              SizedBox(height: 20,),
              Text("Contenu de rapport",
                style: TextStyle(
                    color: Colors.lightBlueAccent,
                    fontSize: 20
                ),),
              SizedBox(height: 20,),
              Text(widget.rapport!.rapportContent!,
                style: TextStyle(
                    fontSize: 18
                ),),
              SizedBox(height: 20,),
              Text('status de rapport',
                  style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontSize: 20
                  )),
              SizedBox(height: 20,),
              // Text(rapportController.listeDeRapports[i].status!),
              // Obx(()=>
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.list,color: Colors.blue,size: 25,),
                  SizedBox(width: MediaQuery.sizeOf(context).width*0.03,),
                  DropdownButton(
                    hint:Text(widget.rapport!.status!,),
                    underline: SizedBox(),
                    icon: SizedBox(),

                    items: rapportController.items!.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items,style: TextStyle(color: Colors.grey),),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        widget.rapport!.status = newValue!;
                      });
                      print(widget.rapport!.status!);
                      print(selectedItem);
                    },
                  ),
                ],
              ),
              SizedBox(height: 100,),
              Center(
                child: GestureDetector(
                  onTap: (){
                    print(widget.rapport!.status!);
                    print(selectedItem);
                    print('///////////////////');
                    print(selectedItem == widget.rapport!.status);
                    print('///////////////////');

                  },
                  child: Container(
                    child: Text("Update"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
