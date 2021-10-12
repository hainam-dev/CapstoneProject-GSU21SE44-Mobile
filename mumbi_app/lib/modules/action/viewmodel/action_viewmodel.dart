import 'dart:convert';

import 'package:mumbi_app/Constant/saveKey.dart';
import 'package:mumbi_app/modules/action/models/action_model.dart';
import 'package:mumbi_app/modules/action/repositories/action_repository.dart';
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
  List<ActionModel> _listActionFine;
  List<ActionModel> _listActionGross;
  List<ActionModel> _listAllAction;

  List<ActionModel> get list => _listActionType;
  List<ActionModel> get listFine => _listActionFine;
  List<ActionModel> get listGross => _listActionGross;
  List<ActionModel> get listAllAction => _listAllAction;

  Future<void> getActionByType(String type) async {
    try {
      var data = await ActionRepository.apiGetActionByType(type);
      if (data != null) {
        Map<String, dynamic> jsonData = jsonDecode(data);
        // print("jsonData " +jsonData.toString());
        if (jsonData['data'] == null) {
          _listActionType = <ActionModel>[];
        } else {
          listdynamic = jsonData['data'];
          _listActionType =
              listdynamic.map((e) => ActionModel.fromJson(e)).toList();
        }
      } else
        _listActionType = <ActionModel>[];
      notifyListeners();
    } catch (e) {
      print("ERROR getActionByType: " + e.toString());
    }
  }

  Future<void> getAllActionByChildId() async {
    try {
      var childID = await storage.read(key: childIdKey);
      print('childID' + childID.toString());
      var data = await ActionRepository.apiGetAllActionIdByChild(childID);
      print('All Action');
      if (data != null) {
        Map<String, dynamic> jsonData = jsonDecode(data);
        if (jsonData['data'] == null) {
          _listAllAction = <ActionModel>[];
        } else {
          listAlldynamic = jsonData['data'];
          _listAllAction =
              listAlldynamic.map((e) => ActionModel.fromJsonAll(e)).toList();
        }
      } else
        _listAllAction = <ActionModel>[];
      notifyListeners();
    } catch (e) {
      print("ERROR getActionIdByChild: " + e.toString());
    }
  }

  Future<bool> upsertAction(ActionModel actionModel) async {
    actionModel.childID = await storage.read(key: childIdKey);
    try {
      String data =
          await ActionRepository.apiUpdateActionIdByChild(actionModel);
      return true;
    } catch (e) {
      print("error upsertAction: " + e.toString());
      return false;
    }
  }

  Future<void> getActionFine() async {
    try {
      var data = await ActionRepository.apiGetActionByType("Tinh");
      // print('data' + data);
      if (data != null) {
        Map<String, dynamic> jsonData = jsonDecode(data);
        // print("jsonData " +jsonData.toString());
        if (jsonData['data'] == null) {
          _listActionFine = <ActionModel>[];
        } else {
          listdynamic = jsonData['data'];
          _listActionFine =
              listdynamic.map((e) => ActionModel.fromJson(e)).toList();
        }
      } else
        _listActionFine = <ActionModel>[];
      notifyListeners();
    } catch (e) {
      print("ERROR getActionByType: " + e.toString());
    }
  }

  Future<void> getActionGross() async {
    try {
      var data = await ActionRepository.apiGetActionByType("Thô");

      if (data != null) {
        Map<String, dynamic> jsonData = jsonDecode(data);
        if (jsonData['data'] == null) {
          _listActionGross = <ActionModel>[];
        } else {
          listdynamic = jsonData['data'];
          _listActionGross =
              listdynamic.map((e) => ActionModel.fromJson(e)).toList();
        }
      } else
        _listActionGross = <ActionModel>[];
      notifyListeners();
    } catch (e) {
      print("ERROR getActionByType: " + e.toString());
    }
  }
}
