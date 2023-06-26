import 'package:flutter/material.dart';
import '../utils.dart';

class listtile extends StatelessWidget {

  final int? color_;
  final String title,date,time;
  final String? Function() ontap;

  listtile({  required this.color_, required this.title, required this.date, required this.time, required this.ontap });

  @override
  Widget build(BuildContext context) {
    return Container(margin: EdgeInsets.all(10),
width: MediaQuery.of(context).size.width,decoration:
BoxDecoration(borderRadius: BorderRadius.circular(10),color: lightPrimary),child:
ListTile(contentPadding: EdgeInsets.all(10), title: Text(title),
trailing: Column(crossAxisAlignment: CrossAxisAlignment.center,
mainAxisAlignment: MainAxisAlignment.center,
children: [
Text(date, style: TextStyle(fontWeight: FontWeight.bold)),
Text(time)] ),
leading: Container(height: 20,width: 20,decoration: BoxDecoration(shape: BoxShape.circle,color: color[color_!])),
  onTap: ontap,
));
}}
