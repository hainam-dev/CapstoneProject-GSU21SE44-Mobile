import 'dart:convert';

import 'package:mumbi_app/Model/childHistory_model.dart';
import 'package:mumbi_app/Repository/child_history_repository.dart';
import 'package:scoped_model/scoped_model.dart';

class ChildHistoryViewModel extends Model{
  static ChildHistoryViewModel _instance;

  static ChildHistoryViewModel getInstance() {
    if (_instance == null) {
      _instance = ChildHistoryViewModel();
    }
    return _instance;
  }

  static void destroyInstance() {
    _instance = null;
  }

  ChildHistoryModel childHistoryModel;
  List<dynamic> childHistoryList;
  List<ChildHistoryModel> childHistoryListModel;

  void getChildHistory(String childId, String date) async{
    if(_instance != null){
      try{
        var data = await ChildHistoryRepository.apiGetChildHistory(childId, date);
        Map<String, dynamic> jsonList = json.decode(data);
        childHistoryList = jsonList['data'];
        if(childHistoryList != null){
          childHistoryListModel = childHistoryList.map((e) => ChildHistoryModel.fromJson(e)).toList();
          if(date != ""){
            childHistoryModel = childHistoryListModel[0];
          }
        }
        notifyListeners();
      }catch (e){
        print("error: " + e.toString());
      }
    }
  }

  Future<bool> updateChildHistory(String childId, ChildHistoryModel childHistoryModel, String date) async {
    try {
      String data = await ChildHistoryRepository.apiUpdateChildHistory(childId, childHistoryModel, date);
      return true;
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }

}