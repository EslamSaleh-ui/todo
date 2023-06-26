import 'package:flutter/material.dart';

class awesomefield extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?) onchange;

  awesomefield(
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
            maxLines: 1,
            maxLength: 25,
            onChanged: onchange,
            obscureText: false,
            keyboardType: TextInputType.text,
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w900),
            enableInteractiveSelection: true,
            decoration: InputDecoration(
              disabledBorder:  UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.pinkAccent.shade400, width: 0.5),
              ),
              enabledBorder:  UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.pinkAccent.shade400, width: 0.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.pinkAccent.shade400, width: 0.5),
              ),
              labelText: '  ${labelText}',
              labelStyle: TextStyle(
                  color: Colors.grey.shade300,
                  fontSize: 15,
                  fontWeight: FontWeight.w900),
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              counterText: "",
            ),validator: (i){
              if(i!.isEmpty)
                return 'This Field Is Needed';
              else if(i.length<8)
                return 'Name Length Must be At Least 8';
              return null;
        },
        ));
  }
}