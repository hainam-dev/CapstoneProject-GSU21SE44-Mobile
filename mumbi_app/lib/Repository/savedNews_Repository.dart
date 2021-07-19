import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mumbi_app/Constant/common_api.dart';
import 'package:mumbi_app/Model/savedNews_model.dart';

class SavedNewsRepository{
  static Future<dynamic> apiSaveNews(SavedNewsModel savedNewsModel) async{
    var response = await http.post(
        Uri.parse("${SAVE_NEWS}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(savedNewsModel.toJson()));
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  static Future<dynamic> apiUnsavedNews(num id) async{
    var response = await http.delete(
        Uri.parse("${UNSAVED_NEWS}${id}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },);
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  static Future<dynamic> apiGetSavedNewsByMom(String momId) async{
    var response = await http.get(Uri.parse("${GET_SAVED_NEWS_BY_MOM_ID}${momId}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },);
    if(response.statusCode == 200){
      return response.body;
    }
  }
}