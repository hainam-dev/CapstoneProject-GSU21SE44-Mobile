import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:mumbi_app/Constant/common_api.dart';

class LogoutRepository {
  static Future<dynamic> apiDeleteFcmToken(String userId, String fcmToken) async{
    var response = await http.delete(
      Uri.parse("${DELETE_TOKEN}${userId}/${fcmToken}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },);
    if (response.statusCode == 200) {
      return response.body;
    }
  }
}
