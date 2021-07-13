import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mumbi_app/Constant/common_api.dart';
import 'package:mumbi_app/Model/child_model.dart';
import 'package:mumbi_app/Model/tooth_model.dart';
import 'package:mumbi_app/View/childrenInfo_view.dart';
import 'package:mumbi_app/ViewModel/tooth_viewmodel.dart';

class ToothRepository {
  static Future<dynamic> apiGetToothInfoByToothId(int toothId) async {
    var response = await http.get(
      Uri.parse("${GET_TOOTHINFO_BY_ID}${toothId}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },);
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  static Future<dynamic> apiGetToothByChildId(String childId, int toothId) async {
    var response = await http.get(
      Uri.parse("${GET_TOOTH_BY_CHILD_ID}${childId}" + "/" + "${toothId}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<dynamic> apiUpsertToothById(ToothModel toothModel) async {
    String toothId = await toothModel.toothId;
    var response = await http.post(
        Uri.parse("${UPSERT_TOOTH_BY_TOOTH_ID}${toothId}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(toothModel.toJson()));
    if (response.statusCode == 200) {
      return response.body;
    }
  }
}