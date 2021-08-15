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
  List<dynamic> listAlldynamic;
  List<ActionModel> _listActionType;
  List<ActionModel> _listAllAction;

  List<ActionModel> get list =>_listActionType;
  List<ActionModel> get listAllAction =>_listAllAction;

  Future<void> getActionByType(String type) async{
    try{
      var data = await ActionRepository.apiGetActionByType(type);
      print('data'+data);
      if(data != null){
        Map<String, dynamic> jsonData = jsonDecode(data);
        // print("jsonData " +jsonData.toString());
        if(jsonData['data'] == null){
          _listActionType = <ActionModel>[];
        } else{
          listdynamic = jsonData['data'];
          _listActionType = listdynamic.map((e) => ActionModel.fromJson(e)).toList();
        }
      } else _listActionType = <ActionModel>[];
      notifyListeners();
    } catch(e){
      print("ERROR getActionByType: " + e.toString());
    }
  }

  Future<void> getAllActionByChildId() async{
    try{
      var childID = await storage.read(key: childIdKey);
      print('childID'+childID.toString());
      var data = await ActionRepository.apiGetAllActionIdByChild(childID);
      print('data All'+data);
      if(data != null){
        Map<String, dynamic> jsonData = jsonDecode(data);
        print("jsonData " +jsonData.toString());
        if(jsonData['data'] == null){
          _listAllAction = <ActionModel>[];
        } else{
          listAlldynamic = jsonData['data'];
          print('listAlldynamic'+listAlldynamic.toString());
          _listAllAction = listAlldynamic.map((e) => ActionModel.fromJsonAll(e)).toList();
          print('_listAllAction'+ _listAllAction.toString());
        }
      } else _listAllAction = <ActionModel>[];
      notifyListeners();
    } catch(e){
      print("ERROR getActionIdByChild: " + e.toString());
    }
  }

  Future<bool> upsertAction(ActionModel actionModel) async {
    var childID = await storage.read(key: childIdKey);
    actionModel.childID= childID;
    try {
      String data = await ActionRepository.apiUpdateActionIdByChild(actionModel);
      print("Update thành công");
      notifyListeners();
      return true;
    } catch (e) {
      print("error upsertAction: " + e.toString());
      return false;
    }
  }
}
