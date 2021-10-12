import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mumbi_app/Constant/common_api.dart';
import 'package:mumbi_app/modules/growing_teeth/models/teeth_model.dart';

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

  static Future<dynamic> apiUpsertToothById(TeethModel teethModel) async {
    String toothId = await teethModel.toothId;
    print("TOOTH VIEW MODEL:" +
        teethModel.toothId.toString() +
        teethModel.grownFlag.toString());
    dynamic jsonData = jsonEncode(teethModel.toJson());
    print("JSONDATA: " + jsonData);
    var response = await http.post(
        Uri.parse("${UPSERT_TOOTH_BY_TOOTH_ID}${toothId}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(teethModel.toJson()));
    print('jsonEncode');

    if (response.statusCode == 200) {
      return response.body;
    }
  }
}
