import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mumbi_app/Constant/common_api.dart';
import 'package:mumbi_app/Model/tooth_model.dart';

class ToothRepository {
  static Future<dynamic> apiGetToothInfoByToothId(int position) async {
    var response = await http.get(
      Uri.parse("${GET_TOOTHINFO_BY_ID}${position}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  static Future<dynamic> apiGetToothByChildId(
      String childId, String toothId) async {
    var response = await http.get(
      Uri.parse("${GET_TOOTH_BY_CHILD_ID}${childId}" + "/" + "${toothId}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  static Future<dynamic> apiGetAllToothByChildId(String childId) async {
    var response = await http.get(
      Uri.parse("${GET_ALL_TOOTH_BY_CHILD_ID}${childId}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  static Future<dynamic> apiUpsertToothById(ToothModel toothModel) async {
    String toothId = await toothModel.toothId;
    print("TOOTH VIEW MODEL:" +
        toothModel.toothId.toString() +
        toothModel.grownFlag.toString());
    dynamic jsonData = jsonEncode(toothModel.toJson());
    print("JSONDATA: " + jsonData);
    var response = await http.post(
        Uri.parse("${UPSERT_TOOTH_BY_TOOTH_ID}${toothId}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(toothModel.toJson()));
    print('jsonEncode');

    if (response.statusCode == 200) {
      return response.body;
    }
  }
}
