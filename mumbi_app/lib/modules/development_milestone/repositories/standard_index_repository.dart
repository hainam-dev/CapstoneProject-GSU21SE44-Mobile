import 'package:http/http.dart' as http;
import 'package:mumbi_app/Constant/common_api.dart';

class StandardRepository {
  static Future<dynamic> apiGetStandardIndex(num gender, bool status) async {
    var response = await http.get(
      Uri.parse("${GET_STANDARD_INDEX}").replace(queryParameters: {
        "Gender" : gender.toString(),
        "Status" : status.toString()}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    }
  }
}
