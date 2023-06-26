import 'package:get_storage/get_storage.dart';
import 'package:todo/utils/internet_connection.dart';
import 'package:todo/utils/utils.dart';

Future<String> login({String? email, String? pw}) async {
  if (await connection()) {
    try {
      final response = await dio.post('https://phpstack-561490-3524079.cloudwaysapps.com/api-start-point/public/api/auth/login',
          data: {"password": pw,"email": email});
      if (response.data != null && response.data['data']['token'] != null)
         tokken.val=response.data['data']['token'];
      return tokken.val==''?"": 'true';
    } catch (e) {
      print(e.toString());
      return 'SomeThing Went Wrong Try Again Later';
    }
  } else {
    return 'No Internet Connection !';
  }
}