import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:mumbi_app/Constant/common_api.dart';

class ActivityRepository{
  static Future<dynamic> apiGetActivityByType(num typeID) async{
    var response = await http.get(Uri.parse("${GET_ACTIVITY_BY_TYPE}")
        .replace(queryParameters: <String, String>{'TypeId': typeID.toString()}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },);
    if(response.statusCode == 200){
      return response.body;
    }
  }
}