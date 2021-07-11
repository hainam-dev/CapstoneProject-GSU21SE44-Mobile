import 'dart:convert';

import 'package:mumbi_app/Constant/saveKey.dart';
import 'package:mumbi_app/Model/child_model.dart';
import 'package:mumbi_app/Model/teeth_model.dart';
import 'package:mumbi_app/Repository/teeth_repository.dart';
import 'package:mumbi_app/main.dart';
import 'package:scoped_model/scoped_model.dart';

class TeethViewModel extends Model{
  static TeethViewModel _instance;

  static TeethViewModel getInstance() {
    if (_instance == null) {
      _instance = TeethViewModel();
    }
    return _instance;
  }

  static void destroyInstance() {
    _instance = null;
  }

  TeethModel teethModel;

  void getTeethById() async{
    int id;
    dynamic teethId = await storage.read(key: teethKey);
    if (teethId == null)
      return null;
    else {
      teethId = jsonDecode(teethId);
      id = teethId;
    }
    try{
      var data = await TeethRepository.apiGetTeethByTeethId(id);
      if(data != null){
        data = jsonDecode(data);

        teethModel = TeethModel.fromJson(data);
        getInstance();
        notifyListeners();
      }
    }catch (e){
      print("Error: " + e.toString());
    }
  }

  Future<bool> updateTeeth(ChildModel childModel,TeethModel teethModel) async {
    try {
      String data = await TeethRepository.apiUpdateTeeth(childModel,teethModel);
      return true;
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }

}