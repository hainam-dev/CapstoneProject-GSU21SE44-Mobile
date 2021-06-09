import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;

class UserRepository {
  static Future<String> callAPILoginGoogle(
      String idToken, String fcmToken) async {
    var response = await http.post(
      Uri.parse('https://mumbi-api.conveyor.cloud/api/Accounts/Authenticate'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json
          .encode(<String, String>{'IdToken': idToken, 'FcmToken': fcmToken}),
    );

    if (response.statusCode == 200) return response.body;
  }
}
