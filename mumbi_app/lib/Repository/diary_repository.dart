import 'package:http/http.dart' as http;
import 'package:mumbi_app/Constant/common_api.dart';

class DiaryRepository{

  static Future<dynamic> apiGetChildDiary(String id) async{
    var response = await http.get(Uri.parse("${GET_ALL_DIARY_OF_CHILD}${id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },);
    if(response.statusCode == 200){
      return response.body;
    }
  }

  static Future<dynamic> apiGetPublicDiary() async{
    var response = await http.get(Uri.parse("${GET_ALL_PUBLIC_DIARY}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },);
    if(response.statusCode == 200){
      return response.body;
    }
  }

  static Future<dynamic> apiDeleteDiary(String id) async {
    var response = await http.put(
      Uri.parse("${DELETE_DIARY}${id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    }
  }
}