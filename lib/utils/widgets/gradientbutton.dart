import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final double? height, width;
  final bool hasRadius;
  final Function()? pressed;
  GradientButton(
      {required this.text,
        required this.pressed,
        this.height ,
        this.width,
        required this.hasRadius });

  @override
  Widget build(BuildContext context) {
    return Container(height: height,width: width,decoration: BoxDecoration(borderRadius:hasRadius
        ? BorderRadius.circular(50)
        : BorderRadius.circular(0),
    gradient: LinearGradient(colors: [Colors.blue.shade400,Colors.cyan.shade200],    begin: Alignment.topLeft,
        end: Alignment.bottomRight, stops: [0.2,0.6]) ),
        child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ), minimumSize: MaterialStateProperty.all(Size(width!, 50)),
              backgroundColor:
              MaterialStateProperty.all(Colors.transparent),
              shadowColor:
              MaterialStateProperty.all(Colors.transparent),
            ),
        onPressed: pressed,
        child: Text(text.tr.toUpperCase(), style: TextStyle(fontSize: 16,color: Colors.white)) ));
  }
}