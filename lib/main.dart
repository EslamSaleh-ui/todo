import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toast/toast.dart';
import 'package:todo/data/login.dart';
import 'package:todo/presentation/homepage.dart';
import 'package:todo/utils/internet_connection.dart';
import 'package:todo/utils/utils.dart';
import 'package:todo/utils/widgets/gradientbutton.dart';
import 'package:todo/utils/widgets/passwordtextfield.dart';
import 'package:todo/utils/widgets/textfield.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  internetChecker();
  await GetStorage.init();
  ErrorWidget.builder=(FlutterErrorDetails D)=>error();
  runApp(const GetMaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'TODO',
    home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: tokken.val==''? MyHomePage():HomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final email=TextEditingController();
  final pw=TextEditingController();
  final _key= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      body:  Center(
        child:SingleChildScrollView(child:  Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('  Login',style: TextStyle(fontSize: 35,fontWeight: FontWeight.w400)),divider(10),
            Container(height:(3* MediaQuery.of(context).size.height)/4,width: MediaQuery.of(context).size.width,
            decoration:BoxDecoration(color: lightPrimary,borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
              boxShadow: [BoxShadow(blurStyle: BlurStyle.outer,color: Colors.black26, offset: Offset(0, 0), blurRadius: 5.0)]) ,
          child:Form(key: _key,child:  Column(mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start
              ,children: [
            divider(100),
            Text('  Email*',style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color:Colors.black)),divider(10),
            textfield(currentController: email, obscureText: false, enableInteractiveSelection: true, keyboardType: TextInputType.emailAddress,
                labelText: 'Enter Your Email', validator: (i){
              if(i!.isEmpty)
                return 'this field is needed';
              else if(!i.isEmail)
                return 'Enter Valid Email';
                }, onEdit: (){
                }),
                divider(20),
                Text('  Password*',style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color:Colors.black)),divider(10)
              ,passwordtextfield(currentController: pw,enableInteractiveSelection: true,onEdit: (){
              },
                labelText: 'Enter Your Password', keyboardType:  TextInputType.visiblePassword)  ,divider(30),
           Center(child:  GradientButton(text: 'Login', pressed: ()async {
             // if(_key.currentState!.validate()){
             String res= await login(email:'flutter-task@test.com',pw:'12345678' );
             if(res=='true')
             Get.offAll(()=>HomePage(),  transition: Transition.leftToRight);
             else
               toast(res);
          print(res);
             // }
          }, hasRadius: true,height: 50,width: MediaQuery.of(context).size.width-100))
              ])  )
            )],
        ))
      )
    );
  }
}