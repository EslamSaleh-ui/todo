import 'package:todo/utils/internet_connection.dart';
import 'package:todo/utils/utils.dart';

Future<String> refresh({String? token}) async {
  if (await connection()) {
    try {
      final response = await dio.post('https://phpstack-561490-3524079.cloudwaysapps.com/api-start-point/public/api/auth/refresh-token',data: {
        "token":token
      });
      if (response.data != null && response.data['data']['token'] != null)
        tokken.val=response.data['data']['token'];
      return tokken.val==''?'': 'true';
    } catch (e) {
      print(e.toString());
      return 'SomeThing Went Wrong Try Again Later';
    }
  } else {
    return 'No Internet Connection !';
  }
}