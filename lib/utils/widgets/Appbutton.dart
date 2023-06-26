import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppButton extends StatelessWidget {
  final String text;
  final double? height, width;
  final bool hasRadius;
  final Color background;
  final Function()? pressed;
  AppButton(
      {required this.text,
      required this.pressed,
      this.height ,
      this.width,
      required this.hasRadius ,
      this.background = Colors.deepPurple});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: background,
            shape: RoundedRectangleBorder(
                borderRadius: hasRadius
                    ? BorderRadius.circular(30)
                    : BorderRadius.circular(0)),
            minimumSize: Size(width??150, height??40)),
        onPressed: pressed,
        child: Text(text.tr.toUpperCase(), style: TextStyle(fontSize: 16,color: Colors.white)));
  }
}
