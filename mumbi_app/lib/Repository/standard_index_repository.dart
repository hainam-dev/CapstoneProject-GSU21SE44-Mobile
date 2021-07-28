import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mumbi_app/Constant/common_api.dart';

class StandardRespisotory {
  static Future<dynamic> apiGetStandedIndexByGender(String gender) async {
    var response = await http.get(
      Uri.parse("${GET_STAND_INDEX_BY_GENDER}${gender}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    }
  }

}
