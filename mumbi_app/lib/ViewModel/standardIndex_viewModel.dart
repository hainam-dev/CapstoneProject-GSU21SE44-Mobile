import 'dart:convert';

import 'package:mumbi_app/Constant/saveKey.dart';
import 'package:mumbi_app/main.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:mumbi_app/Model/standard_index_model.dart';
import 'package:mumbi_app/Repository/standard_index_repository.dart';

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

  StandardIndex standardIndex;
  List<StandardIndex> listStandIndex;
  List<dynamic> listDynamic;

  Future<void> getAllStandard() async{
    dynamic gender = await storage.read(key: childGenderKey);
    try{
      var data = await StandardRespisotory.apiGetStandedIndexByGender(gender);
      if(data != null){
        Map<String, dynamic> jsonData = jsonDecode(data);
        if(jsonData['data' ==null])
          listStandIndex == null;
        else{
          listDynamic = jsonData['data'];
          listStandIndex = listDynamic.map((e) => StandardIndex.fromJson(jsonData));
        }
        notifyListeners();
      }
    }catch (e){
      print("ERROR getAllStandard: " + e.toString());
    }
  }


}