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
  List<dynamic> list;
  List<ToothModel> listTooth;

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
      return false;
    }
  }

  Future<void> getToothByChildId() async{
    var childID = await storage.read(key: childIdKey);

    dynamic toothID = await storage.read(key: toothIdKey);

    try{
      if (toothID == null && childID == null)
        return null;
      var data = await ToothRepository.apiGetToothByChildId(childID, toothID);
      if(data != null){
        Map<String, dynamic> jsonData = jsonDecode(data);
        // print("jsonData " +jsonData.toString());
        if(jsonData['succeeded'] == false){
          toothModel = new ToothModel();
          toothModel.toothId = toothID;
          toothModel.childId = childID;
          toothModel.note = " ";
        } else{
          toothModel = ToothModel.fromJson(jsonData);
        }
        notifyListeners();
      } else {
        toothModel = new ToothModel();
        print("NULL TOOTH");

      }
      // print("toothModel" +toothModel.note.toString());
    }catch (e){
      print("ERROR getToothByChildId:  " + e.toString());
    }
  }

  Future<void> getAllToothByChildId() async{
    var childID = await storage.read(key: childIdKey);
    dynamic toothID = await storage.read(key: toothIdKey);
    if (toothID == null && childID == null)
      return null;
    try{
      //todo
      var data = await ToothRepository.apiGetAllToothByChildId(childID);
      // print("DATA: "+ data);
      if(data != null){
        Map<String, dynamic> jsonData = jsonDecode(data);
        // print("jsonData " +jsonData.toString());
        if(jsonData['data'] == null){
          listTooth = <ToothModel>[];
        } else{
          list = jsonData['data'];
          // print("list: "+list.toString());
          listTooth = list.map((e) => ToothModel.fromJsonModel(e)).toList();
          // print("listTooth: " + listTooth.toString());

          listTooth.sort((a,b) => a.grownDate.toString().compareTo(b.grownDate.toString()));
          // print("listTooth: " + listTooth.first.toString());
        }
        notifyListeners();
      } else {
        listTooth = <ToothModel>[];
        // print("NULL TOOTH");
      }
      // print("toothModel" +toothModel.note.toString());
    }catch (e){
      print("ERROR getAllToothByChildId:  " + e.toString());
    }
  }
}