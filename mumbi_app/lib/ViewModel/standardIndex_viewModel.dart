import 'dart:convert';

import 'package:mumbi_app/Constant/saveKey.dart';
import 'package:mumbi_app/main.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:mumbi_app/Model/standard_index_model.dart';
import 'package:mumbi_app/Repository/standard_index_repository.dart';

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
    // setState();
    var gender = await storage.read(key: childGenderKey);
    // print('gender'+gender.toString());
    try {
      var data = await StandardRespisotory.apiGetStandedIndexByGender(gender);
      if (data != null) {
        Map<String, dynamic> jsonData = jsonDecode(data);
        if (jsonData['data'] == null)
          _listStandIndex = null;
        else {
          listDynamic = jsonData['data'];
          print('listDynamic' + listDynamic.toString());
          _listStandIndex =
              listDynamic.map((e) => StandardIndexModel.fromJson(e)).toList();
          print('listStandIndex ' + listStandIndex[1].gender.toString());
        }
        print("alo2");

        notifyListeners();
      } else
        _listStandIndex = null;
    } catch (e) {
      print("ERROR getAllStandard: " + e.toString());
    }
  }

  // Future<http.Response> getAllStandard() {
  //   return http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
  // }

  void setState() {
    storage.read(key: childGenderKey);
    print("alo1");
    notifyListeners();
  }
}
