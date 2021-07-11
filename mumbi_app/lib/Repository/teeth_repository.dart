import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mumbi_app/Constant/common_api.dart';
import 'package:mumbi_app/Model/child_model.dart';
import 'package:mumbi_app/Model/teeth_model.dart';
import 'package:mumbi_app/View/childrenInfo_view.dart';

class TeethRepository{
  static Future<dynamic> apiGetTeethByTeethId(int teethId) async{
    var response = await http.get(
      Uri.parse("${GET_TOOTH_BY_ID}${teethId}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },);
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  static Future<dynamic> apiUpdateTeeth(ChildModel childModel, TeethModel teethModel) async {
    var response = await http.put(
        Uri.parse("${UPDATE_TOOTH_BY_ID}${childModel.childID}/${teethModel.toothId}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(teethModel.toJson()));
    if (response.statusCode == 200) {
      return response.body;
    }
  }
}