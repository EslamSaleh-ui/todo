import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:locally/locally.dart';
import 'package:toast/toast.dart';
import 'package:todo/data/sqflite.dart';
import 'package:todo/presentation/homepage.dart';
import '../main.dart';

final dio=Dio();
final _db=DB();
final Box=GetStorage();
final task=Note({}).obs;
final task2=Note({}).obs;
final tokken=''.val('tokken');
final sb_=false.val('sb_');

final lightPrimary=Colors.white;
final black=Colors.black;

Divider divider(double height)
{ return Divider(height: height,color: Colors.transparent);}

void toast(String title)
{Toast.show(title,textStyle: TextStyle(color: lightPrimary),duration: Toast.lengthLong,gravity: Toast.bottom,backgroundColor: Colors.cyanAccent);}

List<Color> color=[Colors.white,Colors.white10,Colors.white30,Colors.cyanAccent,Colors.cyan,Colors.green,Colors.blue,
    Colors.deepPurpleAccent,Colors.deepPurple,Colors.red,Colors.amber,Colors.amberAccent,Colors.pink,Colors.pinkAccent,Colors.orange,Colors.deepOrange,
     Colors.brown.shade300,Colors.brown.shade600];

error() {
  return Container(child: Center(child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [Icon(Icons.error_outline,
      color: Colors.red,size: 20
    ), divider(10),
      Text('Something went wrong try again later',style: TextStyle(fontSize:20 ),)
    ],),),);
}

Locally local(BuildContext context) {

  return Locally(
    iosRequestAlertPermission: true,
    iosRequestBadgePermission: true,
    iosRequestSoundPermission: true,
    appIcon: 'ic_launcher',
    context: context,
    payload: 'test',
    pageRoute: MaterialPageRoute(builder: (context) => tokken.val==''? MyHomePage():HomePage()),
  );
}

Future<void> notifications(BuildContext context)
async  { local(context).initializationSettingAndroid;
          local(context).initializationSettingIos;
  await _db.query().then((value) {
    if(value.length!=0){
      value.forEach((element) async {
        Note note=Note.fromMap(element);
       int duration= DateTime.parse(note.date!).compareTo(DateTime.now());
   if(duration>= -1) local(context).schedule(title: note.title, message: note.note, duration: Duration(days: duration==-1?0:duration));
      });}
  });
}