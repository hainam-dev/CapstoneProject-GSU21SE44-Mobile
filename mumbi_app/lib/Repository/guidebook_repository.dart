import 'package:http/http.dart' as http;
import 'package:mumbi_app/Constant/common_api.dart';

class GuidebookRepository{
  static Future<dynamic> apiGetGuidebook(num pageNumber, bool highlightsFlag, [num typeId = 0]) async{
    var response = await http.get(Uri.parse("${GET_GUIDEBOOK}").replace(queryParameters:
    {"TypeId": typeId == 0 ? "" : typeId.toString(),
    "HighlightsFlag": highlightsFlag.toString(),
      "PageNumber": pageNumber.toString()}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },);
    if(response.statusCode == 200){
      return response.body;
    }
  }

  static Future<dynamic> apiGetAllTypeOfGuidebook() async{
    var response = await http.get(Uri.parse("${GET_ALL_TYPE_OF_GUIDEBOOK}").replace(
        queryParameters: {"PageSize": 20.toString()} ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },);
    if(response.statusCode == 200){
      return response.body;
    }
  }
}