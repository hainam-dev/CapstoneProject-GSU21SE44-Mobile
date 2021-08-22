import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mumbi_app/Constant/common_api.dart';
import 'package:mumbi_app/Model/childHistory_model.dart';

class ChildHistoryRepository{
  static Future<dynamic> apiGetChildHistory(String childId, String date) async{
    var response = await http.get(Uri.parse("${GET_CHILD_HISTORY}")
        .replace(queryParameters: <String, String>
    {'ChildId': childId, 'Date' : date}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },);
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  static Future<dynamic> apiUpdateChildHistory(String childId, ChildHistoryModel childHistoryModel, String date) async {
    var response = await http.put(Uri.parse("${UPDATE_CHILD_HISTORY}")
        .replace(queryParameters: <String, String>
    {'ChildId' : childId,'Date' : date}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(childHistoryModel.toJson()));
    if (response.statusCode == 200) {
      return response.body;
    }
  }
}