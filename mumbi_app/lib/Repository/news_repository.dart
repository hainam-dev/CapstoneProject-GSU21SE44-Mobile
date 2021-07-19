import 'package:http/http.dart' as http;
import 'package:mumbi_app/Constant/common_api.dart';

class NewsRepository{
  static Future<dynamic> apiGetNewsById(String id) async{
    var response = await http.get(Uri.parse("${GET_NEWS_BY_ID}${id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },);
    if(response.statusCode == 200){
      return response.body;
    }
  }

  static Future<dynamic> apiGetAllNews() async{
    var response = await http.get(Uri.parse("${GET_ALL_NEWS}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },);
    if(response.statusCode == 200){
      return response.body;
    }
  }


}