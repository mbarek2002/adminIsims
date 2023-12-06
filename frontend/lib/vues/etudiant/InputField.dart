
import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
   InputField({
     Key? key,
     this.title,
     this.hintText,
     this.controller,
     this.icon,
     this.keyboardType
   }) : super(key: key);


   String? title;
   String? hintText;
   TextEditingController? controller;
   IconData? icon;
   TextInputType? keyboardType;
  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: MediaQuery.sizeOf(context).width*0.04),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title!,
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
            child: TextFormField(
              keyboardType:widget.keyboardType,
              controller: widget.controller,
              decoration: InputDecoration(
                prefixIcon: Icon(widget.icon,color: Colors.blue,),
                hintText: widget.hintText!,
                hintStyle: TextStyle(
                    color: Colors.grey
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
