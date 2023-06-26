import 'package:flutter/material.dart';

class textfield extends StatelessWidget {
  final TextEditingController currentController;
  final bool obscureText;
  final bool enableInteractiveSelection;
  final TextInputType keyboardType;
  final String labelText;
  final String? Function() onEdit;
  final String? Function(String?) validator;

  textfield(
      {required this.currentController,
      required this.obscureText,
      required this.enableInteractiveSelection,
      required this.keyboardType,
      required this.labelText,
      required this.validator,
      required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: TextFormField(
            textCapitalization: TextCapitalization.words,
            controller: currentController,
            cursorColor: Colors.white,
            onEditingComplete: onEdit,
            maxLines: 1,
            obscureText: obscureText,
            keyboardType: keyboardType,
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w900),
            enableInteractiveSelection: enableInteractiveSelection,
            decoration: InputDecoration(
              iconColor: Colors.black,
              prefixIconColor: Colors.black,
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
              labelText: '  ${labelText}',
              labelStyle: TextStyle(
                  color: Colors.grey.shade300,
                  fontSize: 15,
                  fontWeight: FontWeight.w900),
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              counterText: "",
            ),
            validator: validator));
  }
}
