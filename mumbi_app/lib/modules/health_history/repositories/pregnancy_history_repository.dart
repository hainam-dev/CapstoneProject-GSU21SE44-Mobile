import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mumbi_app/Constant/common_api.dart';
import 'package:mumbi_app/modules/health_history/models/pregnancy_history_model.dart';

class PregnancyHistoryRepository {
  static Future<dynamic> apiGetPregnancyHistory(
      String childId, String date) async {
    var response = await http.get(
      Uri.parse("${GET_PREGNANCY_HISTORY}").replace(
          queryParameters: <String, String>{'ChildId': childId, 'Date': date}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  static Future<dynamic> apiUpdatePregnancyHistory(String childId,
      PregnancyHistoryModel pregnancyHistoryModel, String date) async {
    var response = await http.put(
        Uri.parse("${UPDATE_PREGNANCY_HISTORY}").replace(
            queryParameters: <String, String>{
              'ChildId': childId,
              'Date': date
            }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(pregnancyHistoryModel.toJson()));
    if (response.statusCode == 200) {
      return response.body;
    }
  }
}
