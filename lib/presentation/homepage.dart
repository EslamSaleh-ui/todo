import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';
import 'package:todo/data/refresh.dart';
import 'package:todo/data/sqflite.dart';
import 'package:todo/main.dart';
import 'package:todo/utils/utils.dart';
import 'package:todo/utils/widgets/Appbutton.dart';
import 'package:todo/utils/widgets/awesomefield.dart';
import 'package:todo/utils/widgets/common_widgets.dart';
import 'package:todo/utils/widgets/gradientbutton.dart';
import 'package:todo/utils/widgets/listtile.dart';
import 'package:todo/utils/widgets/pharagraphfield.dart';
import 'package:todo/utils/widgets/timepicker.dart';

  class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePage();
  }

  class _HomePage extends State<HomePage> {

  final _db=DB();
  final id=0.obs;
  final update_=false.obs;
  final filter_=false.obs;
  final name=TextEditingController();
  final desc=TextEditingController();
  final date=TextEditingController();
  final time=TextEditingController();
  final _key=GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Future<String> res=refresh(token: tokken.val);
    res.then((value) async {
      if(value !='true')
        Get.offAll(()=>MyHomePage(),  transition: Transition.leftToRight);
      await notifications(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return RefreshIndicator(child: Scaffold(
      key: _key,
      onEndDrawerChanged: (b){if(!b)
      {  task.value=Note({});clear();}
        }, endDrawer: Drawer(
        shape: RoundedRectangleBorder(borderRadius:BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(75)) ),
        child:Container(width: MediaQuery.of(context).size.width/2,
        decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(50)),
            gradient:LinearGradient(colors: [Colors.white,Colors.red.shade100],    begin: Alignment.topLeft,
            end: Alignment.bottomRight, stops: [0.2,0.6])  ),child: SingleChildScrollView(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start
                ,children: [divider(40),Obx(() => update_.value? Text('     UPDATE TASK',style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal,color:Colors.black)):
            Text('     NEW TASK',style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal,color:Colors.black))),
            divider(20),    Text('     Color',style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color:Colors.grey.shade500)),
              divider(10),
              Center(child: Container(width:MediaQuery.of(context).size.width,height: 30 , child:
              ListView.separated(reverse: false,itemBuilder: (_,i){
                return GestureDetector(child: Container(height: 20,width: 20,decoration: BoxDecoration(shape: BoxShape.circle,color: color[i])),
                onTap: (){task.value.color=i;
                print(task.value.color);
                });
              }, separatorBuilder: (_,i){return SizedBox(width: 10);}, itemCount: color.length,scrollDirection: Axis.horizontal))
              ), divider(30),
              Text('     Name',style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color:Colors.grey.shade500)),
              divider(10),
            awesomefield(controller: name,labelText:'Task Name', onchange: (i){task.value.title=i;}),
              divider(30),
              Text('     Description',style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color:Colors.grey.shade500)),
              divider(10),
              paragraphfield(controller: desc,labelText:'Task Description', onchange: (i){task.value.note=i;}),
              divider(30),
              Text('     Date',style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color:Colors.grey.shade500)),
              divider(5),
                Obx(() =>   timepicker(type: DateTimePickerType.date, pressed: (i)=>task.value.date=i.toString(), label: 'Date', mask: 'd-MMM-yyyy', intial:update_.value? date.text:''),
                ), divider(30),
              Text('     Time',style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color:Colors.grey.shade500)),
              divider(5),
             Obx(() =>  timepicker(type: DateTimePickerType.time, pressed: (i)=>task.value.time=i.toString(), label: 'Time', mask: 'HH:mm a', intial:update_.value?time.text:'')),
              divider(25),Obx(() => update_.value?
                 Row(crossAxisAlignment:CrossAxisAlignment.center,
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [SizedBox(width: 20),AppButton(text: 'Delete', pressed: (){_db.delete(id.value);
                 Navigator.pop(context);setState(() {});}, hasRadius: true,width: 80,height: 30,background: Colors.red),
                   AppButton(text: 'Update', pressed: (){_db.updates(task.value);
                   Navigator.pop(context);setState(() {});}, hasRadius: true,width: 80,height: 30,background: Colors.blue.shade600),
                 ],) : Padding(padding: EdgeInsets.only(left: 40),child:
              GradientButton(text: 'Add', pressed: () async {
               if((task.value.time==null || task.value.time=='') || (task.value.date==null || task.value.date=='')
               ||(task.value.title==null || task.value.title=='')||(task.value.note==null || task.value.note=='')||
                   (task.value.color==null || task.value.color==''))
                 toast('Task Details not completed ,please complete it');
               else{task.value.id=DateTime.now().microsecond;
                 try{
                 await _db.insertDB(task.value);
               toast('Task Saved');}
               on Exception catch(e){
                 toast('Database Error !');
               }
               Navigator.pop(context);
               clear(); setState(() {});
               }
              }, hasRadius: true,width: 100,height: 30)) )
             ]
            ))) ,
      ),
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0.0,
          iconTheme: IconThemeData(opacity: 0),
          actionsIconTheme: IconThemeData(opacity: 1),
          title: Text('TODO',
          style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal,color:Colors.black)),centerTitle: true,
      actions: [IconButton(onPressed: (){name.clear();filter();}, icon: Icon(Icons.filter_list)),
        IconButton(onPressed: (){tokken.val='';
      Get.offAll(()=>MyHomePage(),  transition: Transition.leftToRight);
        }, icon: Icon(Icons.logout))]),
      body:    Container(height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(gradient:LinearGradient(colors: [Colors.blue.shade100,Colors.red.shade100],    begin: Alignment.topLeft,
              end: Alignment.bottomRight, stops: [0.2,0.6]) ),
          child: FutureBuilder(
            future:filter_.value && !task2.value.isNull?_db.queries(title: task2.value.title,color_: task2.value.color,date: task2.value.date):_db.query()
            ,builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting)
              return loaderPrimary;
            else if(snapshot.hasError)
              return Center(child: Text('Something went wrong !',style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal,color:Colors.black)));
            else if(!snapshot.hasData)
              return Center(child: Text('No Data Found',style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal,color:Colors.black)));
            List<dynamic> list=snapshot.data as List<dynamic>;
            if(list.length==0)
              return Center(child: Text('No Data Found',style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal,color:Colors.black)));
            return ListView.separated(itemBuilder: (_,i){
              Note note=Note.fromMap(list[i]);
              return   listtile(color_: note.color, title: note.title!, date: DateTime.parse(note.date!).day.toString()+" "+DateFormat('MMM').format(DateTime.parse(note.date!)),
                  time: note.time!, ontap: (){update(note);});
            }, separatorBuilder:(_,i){return divider(10);}, itemCount: list.length);
          },)) ,
      floatingActionButton: GradientButton(text: '+', pressed: (){
        update_.value=false; _key.currentState!.openEndDrawer();
      }, hasRadius: true,width: 50,height: 50),
    ),onRefresh: ()async{if(filter_.value){filter_.toggle();task2.value=Note({});} setState(() {});
    });
  }

filter(){
    Get.bottomSheet(Container(
      width: MediaQuery.of(context).size.width,
      height:(3*MediaQuery.of(context).size.height) /4,
      decoration: BoxDecoration(  gradient:LinearGradient(colors: [Colors.white,Colors.red.shade100],    begin: Alignment.topLeft,
          end: Alignment.bottomRight, stops: [0.2,0.6]) ,borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [divider(40),
        Text('     FILTERS',style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal,color:Colors.black)),
        divider(20),    Text('     Color',style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color:Colors.grey.shade500)),
        divider(10),
        Center(child: Container(width:MediaQuery.of(context).size.width,height: 30 , child:
        ListView.separated(reverse: false,itemBuilder: (_,i){
          return GestureDetector(child: Container(height: 20,width: 20,decoration: BoxDecoration(shape: BoxShape.circle,color: color[i])),
              onTap: (){task2.value.color=i;
              print(task2.value.color);
              });
        }, separatorBuilder: (_,i){return SizedBox(width: 10);}, itemCount: color.length,scrollDirection: Axis.horizontal))
        ), divider(30),
        Text('     Name',style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color:Colors.grey.shade500)),
        divider(10),
        awesomefield(controller: name,labelText:'Task Name', onchange: (i){task2.value.title=i;}),
        divider(30),
        Text('     Date',style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color:Colors.grey.shade500)),
        divider(5),
        Obx(() =>   timepicker(type: DateTimePickerType.date, pressed: (i)=>task2.value.date=i.toString(), label: 'Date', mask: 'd-MMM-yyyy', intial:update_.value? date.text:''),
        ), divider(30),Center(child: AppButton(text: 'Filter', pressed: () async {filter_.value=true;Get.back();setState(() {});},
              hasRadius: true,height: 50,width: 150,background: Colors.blue))])
    ),isScrollControlled: true);
}

update(Note n){name.text=n.title!;desc.text=n.note!;time.text=n.time!;date.text=n.date!;id.value=n.id!;update_.value=true;task.value.id=n.id!;
  task.value.color=n.color!;task.value.title=n.title!;task.value.note=n.note!;task.value.date=n.date!;task.value.time=n.time!;
_key.currentState!.openEndDrawer();}

clear(){time.clear();date.clear();desc.clear();name.clear();}
}