import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;

class LoginRepository {
  Future<dynamic> callAPILoginGoogle(String idToken, String fcmToken) async {
    var response = await http.post(
      Uri.parse('https://192.168.1.7:45455/api/Accounts/Authenticate'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json
          .encode(<String, String>{'IdToken': idToken, 'FcmToken': fcmToken}),
    );

    if (response.statusCode == 200) return response.body;
  }
}
