import 'package:http/http.dart' as http;
import 'package:mumbi_app/Constant/common_api.dart';

class NewsRepository{
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