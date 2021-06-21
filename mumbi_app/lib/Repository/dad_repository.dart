import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:mumbi_app/Constant/common_api.dart';
import 'package:mumbi_app/Model/dad_model.dart';

class DadRepository{
  static Future<dynamic> apiGetDadByMomID(String momID) async{
    String url = "${GET_DAD_BY_MOMID}$momID";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.body;
    }
  }


  static Future<dynamic> apiAddDad(DadModel dadModel) async{
    var response = await http.put(
        Uri.parse("${ADD_DAD}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(dadModel.toJson()));
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  static Future<dynamic> apiUpdateDad(DadModel dadModel) async {
    var response = await http.put(
        Uri.parse("${UPDATE_DAD}${dadModel.momID}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(dadModel.toJson()));
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  static Future<dynamic> apiDeleteDad(String accountID) async {
    var response = await http.delete(
        Uri.parse("${DELETE_DAD}${accountID}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    }
  }

}