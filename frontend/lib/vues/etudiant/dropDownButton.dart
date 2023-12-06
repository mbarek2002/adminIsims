

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropDownMenuWidget extends StatefulWidget {
  DropDownMenuWidget({
    Key? key,
    this.items,
    this.dropdownvalue,
    this.titre
  }) : super(key: key);


  List<String>? items;
  String? dropdownvalue;
  String? titre;

  @override
  State<DropDownMenuWidget> createState() => _DropDownMenuWidgetState();
}

class _DropDownMenuWidgetState extends State<DropDownMenuWidget> {



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: MediaQuery.sizeOf(context).width*0.04),
      child:
    // Obx(()=>
    Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.titre!,
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
                    hint:Text(widget.dropdownvalue!,),
                    underline: SizedBox(),
                    icon: SizedBox(),

                    items: widget.items!.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items,style: TextStyle(color: Colors.grey),),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        widget.dropdownvalue = newValue!;
                      });
                      print(widget.dropdownvalue);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
