import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:mumbi_app/Constant/common_api.dart';
import 'package:mumbi_app/Model/mom_model.dart';


class MomRepository{
  static Future<dynamic> apiGetMomByID(String accountID) async{
    String url = "${GET_MOM_BY_ID}$accountID";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  static Future<dynamic> apiUpdateMom(MomModel momModel) async {
    var response = await http.put(
        Uri.parse("${UPDATE_MOM}${momModel.accountID}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(momModel.toJson()));
    if (response.statusCode == 200) {
      return response.body;
    }
  }

}