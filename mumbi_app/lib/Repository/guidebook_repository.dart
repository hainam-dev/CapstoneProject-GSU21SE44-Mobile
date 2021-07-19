import 'package:http/http.dart' as http;
import 'package:mumbi_app/Constant/common_api.dart';

class GuidebookRepository{
  static Future<dynamic> apiGetAllGuidebook() async{
    var response = await http.get(Uri.parse("${GET_ALL_GUIDEBOOK}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },);
    if(response.statusCode == 200){
      return response.body;
    }
  }
}