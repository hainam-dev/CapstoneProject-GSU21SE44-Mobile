import 'dart:convert';

import 'package:mumbi_app/Model/child_model.dart';
import 'package:mumbi_app/Repository/child_repository.dart';
import 'package:scoped_model/scoped_model.dart';

import '../main.dart';

class ChildViewModel extends Model {
  List<dynamic> childList;
  //List<ChildModel> childListModel;
  ChildModel childModel;

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
      childModel = a.map((e) => ChildModel.fromJson(e));
      notifyListeners();
    }catch (e){
      print("error: " + e.toString());
    }
  }

  void getChildByMom() async{
    String momID = "";
    dynamic user = await storage.read(key: "UserInfo");
    if (user == null)
      return null;
    else {
      user = jsonDecode(user);
      momID = user['data']['email'];
    }
    try{
      String data = await ChildRepository.apiGetChildByMom(momID);
      Map<String, dynamic> jsonList = json.decode(data);
      childList = jsonList['data'];
      //childListModel = childList.map((e) => ChildModel.fromJson(e)).toList();
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

  Future<bool> deleteChild(String childID) async {
    try {
      String data = await ChildRepository.apiDeleteChild(childID);
      return true;
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }
}