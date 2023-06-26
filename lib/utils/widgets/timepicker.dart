import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import '../utils.dart';

class timepicker extends StatelessWidget {

  final DateTimePickerType type;
  final Function(String)? pressed;
  final String label,mask,intial;

  timepicker(
      {required this.type,
        required this.pressed, required this.label, required this.mask,required this.intial });

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(5),child:
DateTimePicker(
type: type,
decoration: InputDecoration(
enabledBorder: UnderlineInputBorder(
borderSide: BorderSide(color: black,width: 0.5)
),
suffixIcon: Icon(Icons.arrow_drop_down_sharp)
),
initialValue: intial,
dateMask: mask,
firstDate: DateTime(2000),
lastDate: DateTime(2100),
dateLabelText: label,
onChanged: pressed,
));
  }}