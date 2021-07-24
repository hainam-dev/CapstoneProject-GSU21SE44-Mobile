import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mumbi_app/Constant/common_api.dart';
import 'package:mumbi_app/Model/child_model.dart';
import 'package:mumbi_app/Model/tooth_model.dart';
import 'package:mumbi_app/View/childrenInfo_view.dart';
import 'package:mumbi_app/ViewModel/tooth_viewmodel.dart';

class StandardRespisotory {
  static Future<dynamic> apiGetStandedIndexByGender(int gender) async {
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
