import 'package:flutter/material.dart';

class paragraphfield extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?) onchange;

  paragraphfield(
      { required this.labelText,
        required this.onchange, required this.controller });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: TextFormField(
          controller: controller,
          textCapitalization: TextCapitalization.words,
          cursorColor: Colors.white,
          maxLines: 6,
          maxLength: 125,
          onChanged: onchange,
          obscureText: false,
          keyboardType: TextInputType.text,
          style: TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.w900),
          enableInteractiveSelection: true,
          decoration: InputDecoration(
            filled: true,fillColor:Colors.white70,
            disabledBorder:  OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400, width: 0.5),
            ),
            enabledBorder:  OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400, width: 0.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400, width: 0.5),
            ),
            labelText: '  ${labelText}',
            labelStyle: TextStyle(
                color: Colors.grey.shade300,
                fontSize: 15,
                fontWeight: FontWeight.w900),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            counterText: "",
          ),validator: (i){
          if(i!.isEmpty)
            return 'This Field Is Needed';
          else if(i.length<50)
            return 'Description Length Must be At Least 50';
          return null;
        },
        ));
  }
}