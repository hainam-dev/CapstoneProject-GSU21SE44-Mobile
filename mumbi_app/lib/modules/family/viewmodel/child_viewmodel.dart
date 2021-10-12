import 'dart:convert';
import 'package:mumbi_app/core/auth/login/viewmodel/user_viewmodel.dart';
import 'package:mumbi_app/modules/family/models/child_model.dart';
import 'package:mumbi_app/modules/family/repositories/child_repository.dart';
import 'package:scoped_model/scoped_model.dart';

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

  ChildModel childModel;
  List<dynamic> childList;
  List<ChildModel> childListModel;

  Future<void> getChildByID(String id) async {
    try {
      var data = await ChildRepository.apiGetChildByID(id);
      Map<String, dynamic> jsonList = json.decode(data);
      childList = jsonList['data'];
      if (childList != null) {
        childListModel = childList.map((e) => ChildModel.fromJson(e)).toList();
        childModel = childListModel[0];
      }
      notifyListeners();
    } catch (e) {
      print("error: " + e.toString());
    }
  }

  Future<void> getChildByMom() async {
    String momID = await UserViewModel.getUserID();
    try {
      String data = await ChildRepository.apiGetChildByMom(momID);
      Map<String, dynamic> jsonList = json.decode(data);
      childList = jsonList['data'];
      if (childList != null) {
        childListModel = childList.map((e) => ChildModel.fromJson(e)).toList();
      }
      notifyListeners();
    } catch (e) {
      print("error: " + e.toString());
    }
  }

  Future<bool> addChild(ChildModel childModel) async {
    String momId = await UserViewModel.getUserID();
    childModel.momID = momId;
    try {
      String result = await ChildRepository.apiAddChild(childModel);
      if (result != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }

  Future<bool> updateChildInfo(ChildModel childModel) async {
    try {
      String result = await ChildRepository.apiUpdateChildInfo(childModel);
      if (result != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }

  Future<bool> deleteChild(String childID) async {
    try {
      String result = await ChildRepository.apiDeleteChild(childID);
      if (result != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }
}
