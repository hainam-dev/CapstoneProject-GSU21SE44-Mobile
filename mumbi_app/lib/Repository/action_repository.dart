import 'package:mumbi_app/Constant/common_api.dart';
import 'package:http/http.dart' as http;


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

  static Future<dynamic> apiGetActionIdByChild(String childId, int actionId) async {
    var response = await http.get(
      Uri.parse("${GET_ACTION_ID_BY_CHILDID}${childId}/${actionId}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    }
  }
}