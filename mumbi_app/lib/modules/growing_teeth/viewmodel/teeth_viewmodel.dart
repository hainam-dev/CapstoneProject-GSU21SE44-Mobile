import 'dart:convert';
import 'package:mumbi_app/Constant/saveKey.dart';
import 'package:mumbi_app/modules/growing_teeth/models/teeth_model.dart';
import 'package:mumbi_app/modules/growing_teeth/repositories/teeth_repository.dart';
import 'package:mumbi_app/main.dart';
import 'package:scoped_model/scoped_model.dart';

class TeethViewModel extends Model {
  static TeethViewModel _instance;

  static TeethViewModel getInstance() {
    if (_instance == null) {
      _instance = TeethViewModel();
    }
    return _instance;
  }

  static void destroyInstance() {
    _instance = null;
  }

  TeethInfoModel _toothInforModel;
  TeethModel _toothModel;
  List<dynamic> _list;
  List<TeethModel> _listTooth;

  TeethInfoModel get toothInforModel => _toothInforModel;
  TeethModel get toothModel => _toothModel;
  List<dynamic> get list => _list;
  List<TeethModel> get listTooth => _listTooth;

  Future<void> getToothInfoById() async {
    try {
      dynamic position = await storage.read(key: toothPosInfo);
      position = jsonDecode(position);
      var data = await ToothRepository.apiGetToothInfoByToothId(position);
      if (data != null) {
        Map<String, dynamic> jsonData = jsonDecode(data);
        _toothInforModel = TeethInfoModel.fromJson(jsonData);
        await storage.write(key: toothIdKey, value: _toothInforModel.id);
        getToothByChildId();
        notifyListeners();
      }
    } catch (e) {
      print("Error getToothInfoById: " + e.toString());
    }
  }

  Future<bool> upsertTooth(TeethModel childModel) async {
    try {
      String result = await ToothRepository.apiUpsertToothById(childModel);
      print("Update thành công");
      if (result != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("error upsert tooth: " + e.toString());
      return false;
    }
  }

  Future<void> getToothByChildId() async {
    var childID = await storage.read(key: childIdKey);
    dynamic toothID = await storage.read(key: toothIdKey);

    print('toothID ' + toothID.toString());

    try {
      if (toothID == null && childID == null) return null;
      var data = await ToothRepository.apiGetToothByChildId(childID, toothID);
      print('data' + data);
      if (data != null) {
        Map<String, dynamic> jsonData = jsonDecode(data);
        if (jsonData['succeeded'] == true) {
          if (jsonData['data'] != null) {
            _toothModel = TeethModel.fromJson(jsonData);
          } else {
            _toothModel = new TeethModel();
            _toothModel.toothId = toothID;
            _toothModel.childId = childID;
            _toothModel.note = " ";
          }
        }
      } else {
        _toothModel = new TeethModel();
        print("NULL TOOTH");
      }
      notifyListeners();

      // print("toothModel" +toothModel.note.toString());
    } catch (e) {
      print("ERROR getToothByChildId:  " + e.toString());
    }
  }

  Future<void> getAllToothByChildId() async {
    var childID = await storage.read(key: childIdKey);
    print("CHILDID: " + childID.toString());
    dynamic toothID = await storage.read(key: toothIdKey);
    if (toothID == null && childID == null) return null;
    try {
      var data = await ToothRepository.apiGetAllToothByChildId(childID);
      print("DATA3: " + data);
      if (data != null) {
        Map<String, dynamic> jsonData = jsonDecode(data);
        // print("jsonData " +jsonData.toString());
        if (jsonData['data'] == null) {
          _listTooth = <TeethModel>[];
        } else {
          _list = jsonData['data'];
          _listTooth = _list.map((e) => TeethModel.fromJsonModel(e)).toList();
        }
      } else {
        _listTooth = <TeethModel>[];
      }
      notifyListeners();
    } catch (e) {
      print("ERROR getAllToothByChildId:  " + e.toString());
    }
  }
}
