import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mumbi_app/Constant/common_api.dart';
import 'package:mumbi_app/modules/guidebook/models/saved_guidebook_model.dart';

class SavedGuidebookRepository {
  static Future<dynamic> apiGetSavedGuidebook(
      String momId, num pageNumber) async {
    var response = await http.get(
      Uri.parse("${GET_SAVED_GUIDEBOOK}").replace(queryParameters: {
        "MomId": momId,
        "PageNumber": pageNumber.toString()
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  static Future<dynamic> apiCheckSavedGuidebook(
      String momId, String guidebookId) async {
    var response = await http.get(
      Uri.parse("${GET_SAVED_GUIDEBOOK}").replace(
          queryParameters: {"MomId": momId, "GuidebookId": guidebookId}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  static Future<dynamic> apiSaveGuidebook(
      SavedGuidebookModel savedGuidebookModel) async {
    var response = await http.post(Uri.parse("${SAVE_GUIDEBOOK}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(savedGuidebookModel.toJson()));
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  static Future<dynamic> apiUnsavedGuidebook(num id) async {
    var response = await http.delete(
      Uri.parse("${UNSAVED_GUIDEBOOK}${id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    }
  }
}
