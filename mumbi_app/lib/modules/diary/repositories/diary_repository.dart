import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mumbi_app/Constant/common_api.dart';
import 'package:mumbi_app/modules/diary/models/diary_model.dart';

class DiaryRepository {
  static Future<dynamic> apiGetChildDiary(String id, num pageNumber) async {
    var response = await http.get(
      Uri.parse("${GET_ALL_DIARY_OF_CHILD}").replace(
          queryParameters: <String, String>{
            'ChildId': id,
            'PageNumber': pageNumber.toString()
          }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  static Future<dynamic> apiAddDiary(DiaryModel diaryModel) async {
    var response = await http.post(Uri.parse("${ADD_DIARY}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(diaryModel.toJson()));
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  static Future<dynamic> apiUpdateDiary(DiaryModel diaryModel) async {
    var response = await http.put(Uri.parse("${UPDATE_DIARY}${diaryModel.id}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(diaryModel.toJson()));
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  static Future<dynamic> apiDeleteDiary(num id) async {
    var response = await http.put(
      Uri.parse("${DELETE_DIARY}${id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    }
  }
}
