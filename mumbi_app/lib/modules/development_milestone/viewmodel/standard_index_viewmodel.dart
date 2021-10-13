import 'dart:convert';

import 'package:mumbi_app/modules/development_milestone/models/standard_index_model.dart';
import 'package:mumbi_app/modules/development_milestone/repositories/standard_index_repository.dart';
import 'package:scoped_model/scoped_model.dart';

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

  bool isLoading;
  List<StandardIndexModel> standardIndexListModel;

  void getStandardIndex(num gender, bool status) async {
    try {
      isLoading = true;
      var data = await StandardRepository.apiGetStandardIndex(gender, status);
      Map<String, dynamic> jsonList = jsonDecode(data);
      List<dynamic> standardIndexList = jsonList['data'];
      if (standardIndexList != null) {
        standardIndexListModel = standardIndexList.map((e) => StandardIndexModel.fromJson(e)).toList();
      } else{
        standardIndexListModel = null;
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print("error: " + e.toString());
    }
  }
}
