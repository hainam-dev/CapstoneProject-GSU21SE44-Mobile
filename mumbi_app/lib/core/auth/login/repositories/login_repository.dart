import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:mumbi_app/Constant/common_api.dart';

class LoginRepository {
  Future<dynamic> callAPILoginGoogle(String idToken, String fcmToken) async {
    var response = await http.post(
      Uri.parse('${LOGIN}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json
          .encode(<String, String>{'idToken': idToken, 'fcmToken': fcmToken}),
    );

    if (response.statusCode == 200) return response.body;
  }
}
