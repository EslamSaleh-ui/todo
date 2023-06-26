import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class passwordtextfield extends StatelessWidget {

  final TextEditingController currentController;
  final bool enableInteractiveSelection;
  final TextInputType keyboardType;
  final String? Function() onEdit;
  final String labelText;

  passwordtextfield({ required this.currentController,
    required this.enableInteractiveSelection, required this.keyboardType,
    required this.labelText, required this.onEdit,
     });

  final obscuse=true.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(()=>Padding(padding: EdgeInsets.symmetric(horizontal: 15),child:TextFormField(
      textCapitalization:   TextCapitalization.words,
      controller: currentController,
      cursorColor: Colors.white,
      maxLines: 1,
      obscureText: obscuse.value,
      keyboardType: keyboardType,
      style:  TextStyle(color: Colors.black,fontSize: 15,fontWeight:FontWeight.w900),
      enableInteractiveSelection: enableInteractiveSelection,
      decoration: InputDecoration(
        iconColor: Colors.black,
        suffixIcon: IconButton(icon: Icon(obscuse.value?Icons.remove_red_eye_rounded:
            FontAwesomeIcons.eyeSlash,color: Colors.black),
        onPressed: (){
          if(obscuse.value)
        obscuse.value=false;
          else
          obscuse.value=true;
        }),
        prefixIconColor:Colors.black ,
        filled: true,fillColor: Colors.grey.shade100,
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300, width: 0.5),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 0.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 0.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300, width: 0.5),
        ),
        labelText: labelText,
        labelStyle:  TextStyle(color:Colors.grey.shade300,fontSize: 15,fontWeight:FontWeight.w900 ),
        counterText: "",
      ),
      validator:(i){
        String v= r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
        RegExp S=new RegExp(v);
        if(i!.isEmpty)
          return 'this field is needed';
        else if(!S.hasMatch(i) )
          return   "Password must contains at least 8 chars between numbers,digits and chars";
        return null;
      },
    ))
    );
  }
}