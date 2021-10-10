import 'package:http/http.dart' as http;
import 'package:mumbi_app/Constant/common_api.dart';

class NewsRepository{
  static Future<dynamic> apiGetNews(num pageNumber, [num typeId = 0]) async{
    var response = await http.get(Uri.parse("${GET_NEWS}").replace(queryParameters: {
      "TypeId" : typeId == 0 ? "" : typeId.toString(),
      "PageNumber": pageNumber.toString()}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },);
    if(response.statusCode == 200){
      return response.body;
    }
  }
}