import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:mumbi_app/Constant/common_api.dart';
import 'package:mumbi_app/Model/child_model.dart';

class ChildRepository{
  static Future<dynamic> apiAddChild(ChildModel childModel) async{
    var response = await http.post(
        Uri.parse("${ADD_CHILD}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(childModel.toJson()));
    if (response.statusCode == 200) {
      return response.body;
    }
  }


  static Future<dynamic> apiGetChildByMom(String momID) async{
    var response = await http.get(Uri.parse("${GET_CHILD_BY_MOM}${momID}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },);
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  static Future<dynamic> apiGetChildByID(ChildModel childModel) async{
    var response = await http.get(
      Uri.parse("${UPDATE_CHILD_INFO}${childModel.id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },);
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  static Future<dynamic> apiGetChildById2(String id) async{
    var response = await http.get(
      Uri.parse("${GET_CHILD_BY_ID}${id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },);
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  static Future<dynamic> apiUpdateChildInfo(ChildModel childModel) async {
    var response = await http.put(
        Uri.parse("${UPDATE_CHILD_INFO}${childModel.id}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(childModel.toJson()));
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  static Future<dynamic> apiDeleteChild(String id) async {
    var response = await http.put(
      Uri.parse("${DELETE_CHILD}${id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    }
  }

}