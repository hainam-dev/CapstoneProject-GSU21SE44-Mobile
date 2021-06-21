import 'dart:convert';

import 'package:mumbi_app/Model/child_model.dart';
import 'package:mumbi_app/Repository/child_repository.dart';
import 'package:scoped_model/scoped_model.dart';

class ChildViewModel extends Model {
  ChildModel childInfo;

  Future<bool> addChild(ChildModel childModel) async {
    try {
      String data = await ChildRepository.apiAddChild(childModel);
      return true;
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }

  void getChildByID(ChildModel childModel) async{
    try{
      String data = await ChildRepository.apiGetChildByID(childModel);
      var a = json.decode(data);
      childInfo = a.map((e) => ChildModel.fromJson(e));
      notifyListeners();
    }catch (e){
      print("error: " + e.toString());
    }
  }


  Future<bool> updateChildInfo(ChildModel childModel) async {
    try {
      String data = await ChildRepository.apiUpdateChildInfo(childModel);
      return true;
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }

  Future<bool> updatePregnancyInfo(ChildModel childModel) async {
    try {
      String data = await ChildRepository.apiUpdatePregnancyInfo(childModel);
      return true;
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }

  void deleteChild(String childID) async {
    try {
      String data = await ChildRepository.apiDeleteChild(childID);
    } catch (e) {
      print("error: " + e.toString());
    }
  }
}