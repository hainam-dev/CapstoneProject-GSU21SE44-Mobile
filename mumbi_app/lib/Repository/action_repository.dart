import 'dart:convert';

import 'package:mumbi_app/Constant/common_api.dart';
import 'package:http/http.dart' as http;
import 'package:mumbi_app/Model/action_model.dart';


class ActionRepository{
  static Future<dynamic> apiGetActionByType(String type) async {
    var response = await http.get(
      Uri.parse("${GET_ACTION_BY_TYPE}${type}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  static Future<dynamic> apiGetAllActionIdByChild(String childId) async {
    var response = await http.get(
      Uri.parse("${GET_ACTION_ID_BY_CHILDID}${childId}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  static Future<dynamic> apiUpdateActionIdByChild(ActionModel actionModel) async {
    var response = await http.post(
        Uri.parse("${UPDATE_ACTION_ID_BY_CHILDID}${actionModel.childID}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(actionModel.toJsonActionChild()));
    print('jsonEncode');
    if (response.statusCode == 200) {
      return response.body;
    }
  }
}