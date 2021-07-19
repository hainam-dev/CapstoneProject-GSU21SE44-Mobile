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

  Future<void> getToothInfoById() async{
    try{
      dynamic position = await storage.read(key: toothPosInfo);
      // if (position == null)
      //   return null;
      // else {
      position = jsonDecode(position);
      // }
      var data = await ToothRepository.apiGetToothInfoByToothId(position);
      if(data != null){
        Map<String, dynamic> jsonData = jsonDecode(data);
        toothInforModel = ToothInfoModel.fromJson(jsonData);
        var toothId = storage.write(key: toothIdKey, value: toothInforModel.id);
        notifyListeners();
      }
    }catch (e){
      print("Error getToothInfoById: " + e.toString());
    }
  }

  Future<bool> upsertTooth(ToothModel childModel) async {
    try {
      String data = await ToothRepository.apiUpsertToothById(childModel);
      print("Update thành công");
      return true;
    } catch (e) {
      print("error upsert tooth: " + e.toString());
    }
  }

  Future<void> getToothByChildId() async{
    try{
      var childID = await storage.read(key: childIdKey);

      dynamic toothID = await storage.read(key: toothIdKey);

      if (toothID == null && childID == null)
        return null;
      //todo
      var data = await ToothRepository.apiGetToothByChildId(childID, toothID);
      if(data != null){
        Map<String, dynamic> jsonData = jsonDecode(data);
        // print("JSON " +jsonData.toString());
        if(jsonData['succeeded'] == false){
          toothModel = new ToothModel();
          toothModel.toothId = toothID;
          toothModel.childId = childID;
        } else{
          toothModel = ToothModel.fromJson(jsonData);
        }
        notifyListeners();
      } else toothModel = new ToothModel();
    }catch (e){
      print("ERROR getToothByChildId:  " + e.toString());
    }
  }
}