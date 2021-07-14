import 'dart:convert';

import 'package:mumbi_app/Constant/saveKey.dart';
import 'package:mumbi_app/Model/child_model.dart';
import 'package:mumbi_app/Model/tooth_model.dart';
import 'package:mumbi_app/Repository/teeth_repository.dart';
import 'package:mumbi_app/main.dart';
import 'package:scoped_model/scoped_model.dart';

class ToothViewModel extends Model{
  static ToothViewModel _instance;

  static ToothViewModel getInstance() {
    if (_instance == null) {
      _instance = ToothViewModel();
    }
    return _instance;
  }

  static void destroyInstance() {
    _instance = null;
  }

  ToothInfoModel toothInforModel;
  ToothModel toothModel;

  void getToothInfoById() async{
    int id;
    dynamic toothId = await storage.read(key: toothInforKey);
    if (toothId == null)
      return null;
    else {
      toothId = jsonDecode(toothId);
      id = toothId;
    }
    try{
      var data = await ToothRepository.apiGetToothInfoByToothId(id);
      if(data != null){
        data = jsonDecode(data);

        toothInforModel = ToothInfoModel.fromJson(data);
        getInstance();
        notifyListeners();
      }
    }catch (e){
      print("Error getToothInfoById: " + e.toString());

    }
  }

  Future<bool> upsertTooth(ToothModel childModel) async {
    try {
      String data = await ToothRepository.apiUpsertToothById(childModel);
      return true;
    } catch (e) {
      print("error upsert tooth: " + e.toString());
    }
    return false;
  }

  void getToothByChildId() async{
    int idTooth;
    var idChild;
    var childID = await storage.read(key: childId);
    // print("Mang child:" +childID.toString());
    dynamic toothID = await storage.read(key: toothInforKey);
    // print("Mang tooth:" +toothID.toString());


    if (toothID == null && childID == null)
      return null;
    else {
      toothID = jsonDecode(toothID);
      idTooth = toothID;
      idChild = childID;
    }
    try{
      var data = await ToothRepository.apiGetToothByChildId(idChild, idTooth);
      if(data != null){
        data = jsonDecode(data);

        toothModel = ToothModel.fromJson(data);
        // getInstance();
        notifyListeners();
      }

    }catch (e){
      print("Error getToothByChildId:  " + e.toString());
      toothModel = null;
    }
  }

  // Future<bool> updateChildInfo(ChildModel childModel) async {
  //   try {
  //     String data = await ChildRepository.apiUpdateChildInfo(childModel);
  //     return true;
  //   } catch (e) {
  //     print("error: " + e.toString());
  //   }
  //   return false;
  // }

  // Future<bool> upserTooth(ToothModel toothModel) async {
  //   int idTooth;
  //   dynamic toothID = await storage.read(key: toothInforKey);
  //   String momId = await ToothRepository.apiUpsertToothById(toothModel, toothID);
  //   childModel.momID = momId;
  //   try {
  //     String data = await ChildRepository.apiAddChild(childModel);
  //     notifyListeners();
  //     return true;
  //   } catch (e) {
  //     print("error: " + e.toString());
  //   }
  //   return false;
  // }
}