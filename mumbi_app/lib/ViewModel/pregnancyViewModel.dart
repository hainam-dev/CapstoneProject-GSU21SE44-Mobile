import 'dart:convert';

import 'package:mumbi_app/Model/pregnancyHistory_model.dart';
import 'package:mumbi_app/Repository/pregnancy_history_repository.dart';
import 'package:scoped_model/scoped_model.dart';

class PregnancyHistoryViewModel extends Model{
  static PregnancyHistoryViewModel _instance;

  static PregnancyHistoryViewModel getInstance() {
    if (_instance == null) {
      _instance = PregnancyHistoryViewModel();
    }
    return _instance;
  }

  static void destroyInstance() {
    _instance = null;
  }

  PregnancyHistoryModel pregnancyHistoryModel;
  List<dynamic> pregnancyHistoryList;
  List<PregnancyHistoryModel> pregnancyHistoryListModel;

  void getPregnancyHistory(String childId, String date) async{
      try{
        var data = await PregnancyHistoryRepository.apiGetPregnancyHistory(childId, date);
        Map<String, dynamic> jsonList = json.decode(data);
        pregnancyHistoryList = jsonList['data'];
        if(pregnancyHistoryList != null){
          pregnancyHistoryListModel = pregnancyHistoryList.map((e) => PregnancyHistoryModel.fromJson(e)).toList();
          if(date != ""){
            pregnancyHistoryModel = pregnancyHistoryListModel[0];
          }
        }else{
          pregnancyHistoryModel = null;
        }
        notifyListeners();
      }catch (e){
        print("error: " + e.toString());
      }
  }

  Future<bool> updatePregnancyHistory(String childId, PregnancyHistoryModel pregnancyHistoryModel, String date) async {
    try {
      String result = await PregnancyHistoryRepository.apiUpdatePregnancyHistory(childId, pregnancyHistoryModel, date);
      if(result != null){
        return true;
      }else{
        return false;
      }
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }

}