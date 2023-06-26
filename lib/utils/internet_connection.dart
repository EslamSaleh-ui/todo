import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:todo/utils/utils.dart';


void internetChecker(){
  InternetConnectionChecker().onStatusChange.listen((status) async {
    switch (status) {
      case InternetConnectionStatus.connected:
        {if(sb_.val){
          Get.showSnackbar(GetSnackBar(backgroundColor: Colors.green,
            title: 'You Are Online'.tr,
            titleText: Text(
                'You Are Online'.tr, style: TextStyle(color: lightPrimary)),
            message: '',
            messageText: Text(''),
            duration: Duration(seconds: 5),));
        sb_.val=false;}
        } break;
      case InternetConnectionStatus.disconnected:
        {
        Get.showSnackbar(GetSnackBar(backgroundColor: Colors.red,title:'You Are Offline !'.tr ,titleText: Text('You Are Offline !'.tr,style: TextStyle(color: lightPrimary)),message: '',
            messageText: Text(''),duration: Duration(seconds: 5), ));
        sb_.val=true;}
        break; }
  });
}

Future<bool> connection()async{
  return await InternetConnectionChecker().hasConnection;
}
