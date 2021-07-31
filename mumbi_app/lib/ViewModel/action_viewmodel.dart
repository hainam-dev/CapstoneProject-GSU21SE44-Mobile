import 'dart:convert';

import 'package:mumbi_app/Constant/saveKey.dart';
import 'package:mumbi_app/Model/action_model.dart';
import 'package:mumbi_app/Repository/action_repository.dart';
import 'package:mumbi_app/main.dart';
import 'package:scoped_model/scoped_model.dart';

class ActionViewModel extends Model {
  static ActionViewModel _instance;

  static ActionViewModel getInstance() {
    if (_instance == null) {
      _instance = ActionViewModel();
    }
    return _instance;
  }

  static void destroyInstance() {
    _instance = null;
  }

  ActionModel actionModel;
  List<dynamic> listdynamic;
  List<ActionModel> _listAction;

  List<ActionModel> get list{ //returns a copy of list
    return [..._listAction];
  }

  Future<void> getActionByType(String type) async{
    try{
      var data = await ActionRepository.apiGetActionByType(type);
      print('data'+data);
      if(data != null){
        Map<String, dynamic> jsonData = jsonDecode(data);
        // print("jsonData " +jsonData.toString());
        if(jsonData['data'] == null){
          _listAction = <ActionModel>[];
        } else{
          listdynamic = jsonData['data'];
          _listAction = listdynamic.map((e) => ActionModel.fromJson(e)).toList();
        }
      } else _listAction = <ActionModel>[];
      notifyListeners();
    } catch(e){
      print("ERROR getActionByType: " + e.toString());
    }
  }

  Future<void> getActionByActionId(int actionId) async{
    try{
      var childID = await storage.read(key: childIdKey);
      print('childID'+childID.toString());
      var data = await ActionRepository.apiGetActionIdByChild(childID, actionId);
      print('data'+data);
      if(data != null){
        Map<String, dynamic> jsonData = jsonDecode(data);
        // print("jsonData " +jsonData.toString());
        if(jsonData['succeeded'] == false){
          actionModel = ActionModel();
          actionModel.checkedFlag = false;
        } else{
          actionModel = ActionModel.fromJson(jsonData['data']);
        }
      } else actionModel = ActionModel();
      notifyListeners();
    } catch(e){
      print("ERROR getActionIdByChild: " + e.toString());
    }
  }
}
