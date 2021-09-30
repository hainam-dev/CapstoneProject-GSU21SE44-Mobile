import 'package:http/http.dart' as http;
import 'package:mumbi_app/Constant/common_api.dart';

class GuidebookRepository{
  static Future<dynamic> apiGetGuidebook() async{
    var response = await http.get(Uri.parse("${GET_GUIDEBOOK}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },);
    if(response.statusCode == 200){
      return response.body;
    }
  }

  static Future<dynamic> apiGetGuidebookByType(num typeId) async{
    var response = await http.get(Uri.parse("${GET_GUIDEBOOK}").replace(queryParameters:
    {"TypeId": typeId.toString()}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },);
    if(response.statusCode == 200){
      return response.body;
    }
  }

  static Future<dynamic> apiCountQuantity(num typeId) async{
    var response = await http.get(Uri.parse("${GET_GUIDEBOOK}").replace(queryParameters:
    {"TypeId": typeId.toString(),
      "PageSize" : "1"}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },);
    if(response.statusCode == 200){
      return response.body;
    }
  }

  static Future<dynamic> apiGetAllTypeOfGuidebook() async{
    var response = await http.get(Uri.parse("${GET_ALL_TYPE_Of_GUIDEBOOK}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },);
    if(response.statusCode == 200){
      return response.body;
    }
  }
}