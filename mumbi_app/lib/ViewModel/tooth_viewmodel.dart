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

  ToothInfoModel _toothInforModel;
  ToothModel _toothModel;
  List<dynamic> _list;
  List<ToothModel> _listTooth;

  ToothInfoModel get  toothInforModel => _toothInforModel;
  ToothModel get toothModel => _toothModel;
  List<dynamic> get list => _list;
  List<ToothModel> get listTooth => _listTooth;

  Future<void> getToothInfoById() async{
    try{
      dynamic position = await storage.read(key: toothPosInfo);
      position = jsonDecode(position);
      var data = await ToothRepository.apiGetToothInfoByToothId(position);
      if(data != null){
        Map<String, dynamic> jsonData = jsonDecode(data);
        _toothInforModel = ToothInfoModel.fromJson(jsonData);
        var toothId = storage.write(key: toothIdKey, value: _toothInforModel.id);
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
      notifyListeners();
      return true;
    } catch (e) {
      print("error upsert tooth: " + e.toString());
      return false;
    }
  }

  Future<void> getToothByChildId() async{
    var childID = await storage.read(key: childIdKey);
    dynamic toothID = await storage.read(key: toothPosInfo);

    print('toothID '+toothID.toString());

    try{
      if (toothID == null && childID == null)
        return null;
      var data = await ToothRepository.apiGetToothByChildId(childID, toothID);
      if(data != null){
        Map<String, dynamic> jsonData = jsonDecode(data);
        if(jsonData['succeeded'] == false){
          _toothModel = new ToothModel();
          _toothModel.toothId = toothID;
          _toothModel.childId = childID;
          _toothModel.note = " ";
        } else{
          _toothModel = ToothModel.fromJson(jsonData);
        }
      } else {
        _toothModel = new ToothModel();
        print("NULL TOOTH");
      }
      notifyListeners();

      // print("toothModel" +toothModel.note.toString());
    }catch (e){
      print("ERROR getToothByChildId:  " + e.toString());
    }
  }

  Future<void> getAllToothByChildId() async{
    var childID = await storage.read(key: childIdKey);
    print("CHILDID: "+ childID.toString());
    dynamic toothID = await storage.read(key: toothIdKey);
    if (toothID == null && childID == null)
      return null;
    try{
      var data = await ToothRepository.apiGetAllToothByChildId(childID);
      print("DATA3: "+ data);
      if(data != null){
        Map<String, dynamic> jsonData = jsonDecode(data);
        print("jsonData " +jsonData.toString());
        if(jsonData['data'] == null){
          _listTooth = <ToothModel>[];
        } else{
          _list = jsonData['data'];
          _listTooth = _list.map((e) => ToothModel.fromJsonModel(e)).toList();
        }
      } else {
        _listTooth = <ToothModel>[];
      }
      notifyListeners();
    }catch (e){
      print("ERROR getAllToothByChildId:  " + e.toString());
    }
  }
}