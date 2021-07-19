import 'dart:convert';

import 'package:mumbi_app/Model/child_model.dart';
import 'package:mumbi_app/Repository/child_repository.dart';
import 'package:mumbi_app/ViewModel/user_viewmodel.dart';
import 'package:scoped_model/scoped_model.dart';

import '../main.dart';

class ChildViewModel extends Model {

  static ChildViewModel _instance;

  static ChildViewModel getInstance() {
    if (_instance == null) {
      _instance = ChildViewModel();
    }
    return _instance;
  }

  static void destroyInstance() {
    _instance = null;
  }

  List<dynamic> childList;
  List<ChildModel> childListModel;

  Future<bool> addChild(ChildModel childModel) async {
    String momId = await UserViewModel.getUserID();
    childModel.momID = momId;
    try {
      String data = await ChildRepository.apiAddChild(childModel);
      notifyListeners();
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

  Future<void> getChildByMom() async{
    String momID = await UserViewModel.getUserID();
    try{
      String data = await ChildRepository.apiGetChildByMom(momID);
      Map<String, dynamic> jsonList = json.decode(data);
      childList = jsonList['data'];
      childListModel = childList.map((e) => ChildModel.fromJson(e)).toList();
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

  Future<bool> deleteChild(String childID) async {
    try {
      String data = await ChildRepository.apiDeleteChild(childID);
      destroyInstance();
      return true;
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }
}