import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:mumbi_app/Constant/common_api.dart';
import 'package:mumbi_app/Model/dad_model.dart';

class DadRepository{
  static Future<dynamic> apiGetDadByMomID(String momID) async{
    var response = await http.get(
        Uri.parse("${GET_DAD_BY_MOM}${momID}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },);
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  static Future<dynamic> apiAddDad(DadModel dadModel) async{
    var response = await http.post(
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
        Uri.parse("${UPDATE_DAD}${dadModel.Id}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(dadModel.toJson()));
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  static Future<dynamic> apiDeleteDad(String dadID) async {
    var response = await http.put(
        Uri.parse("${DELETE_DAD}${dadID}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    }
  }
}