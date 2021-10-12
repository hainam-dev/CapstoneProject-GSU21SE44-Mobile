import 'dart:convert';

import 'package:mumbi_app/Constant/saveKey.dart';
import 'package:mumbi_app/main.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:mumbi_app/modules/standard_index/models/standard_index_model.dart';
import 'package:mumbi_app/modules/standard_index/repositories/standard_index_repository.dart';

class StandardIndexViewModel extends Model {
  static StandardIndexViewModel _instance;

  static StandardIndexViewModel getInstance() {
    if (_instance == null) {
      _instance = StandardIndexViewModel();
    }
    return _instance;
  }

  static void destroyInstance() {
    _instance = null;
  }

  StandardIndexModel standardIndex;
  List<StandardIndexModel> _listStandIndex;
  List<StandardIndexModel> get listStandIndex => _listStandIndex;
  List<dynamic> listDynamic;
  var gender;

  Future<StandardIndexModel> getAllStandard() async {
    var gender = await storage.read(key: childGenderKey);
    try {
      var data = await StandardRespisotory.apiGetStandedIndexByGender(gender);
      if (data != null) {
        Map<String, dynamic> jsonData = jsonDecode(data);
        if (jsonData['data'] == null)
          _listStandIndex = null;
        else {
          listDynamic = jsonData['data'];
          _listStandIndex =
              listDynamic.map((e) => StandardIndexModel.fromJson(e)).toList();
        }
        notifyListeners();
      } else
        _listStandIndex = null;
    } catch (e) {
      print("ERROR getAllStandard: " + e.toString());
    }
  }
}
