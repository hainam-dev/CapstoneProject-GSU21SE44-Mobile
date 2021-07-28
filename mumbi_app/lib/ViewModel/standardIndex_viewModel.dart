import 'dart:convert';

import 'package:mumbi_app/Constant/saveKey.dart';
import 'package:mumbi_app/main.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:mumbi_app/Model/standard_index_model.dart';
import 'package:mumbi_app/Repository/standard_index_repository.dart';
import 'package:http/http.dart' as http;


class StandardIndexViewModel extends Model{
  static StandardIndexViewModel _instance;

  static StandardIndexViewModel getInstance() {
    if (_instance == null) {
      _instance = StandardIndexViewModel();
    }
    return _instance;
  }

  static void destroyInstance() {
    _instance = null;
  }

  StandardIndexModel standardIndex;
  List<StandardIndexModel> listStandIndex;
  List<dynamic> listDynamic;

  Future<StandardIndexModel> getAllStandard() async{
    var gender = await storage.read(key: childGenderKey);
    // print('gender'+gender.toString());
    try{
      var data = await StandardRespisotory.apiGetStandedIndexByGender(gender);
      if(data != null){
        Map<String, dynamic> jsonData = jsonDecode(data);
        if(jsonData['data'] == null)
          listStandIndex = null;
        else{
          listDynamic = jsonData['data'];
          // print('listDynamic'+listDynamic.toString());
          listStandIndex = listDynamic.map((e) => StandardIndexModel.fromJson(e)).toList();
          // print('listStandIndex' +listStandIndex[1].gender.toString());
        }
        notifyListeners();
      } else listStandIndex = null;
    }catch (e){
      print("ERROR getAllStandard: " + e.toString());
    }
  }

  // Future<http.Response> getAllStandard() {
  //   return http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
  // }

}