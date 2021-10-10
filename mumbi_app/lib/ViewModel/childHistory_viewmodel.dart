import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:mumbi_app/Constant/saveKey.dart';
import 'package:mumbi_app/Model/childHistory_model.dart';
import 'package:mumbi_app/Repository/child_history_repository.dart';
import 'package:mumbi_app/main.dart';
import 'package:scoped_model/scoped_model.dart';

class ChildHistoryViewModel extends Model {
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
  List<ChildHistoryModel> childListHistoryChild;

  void getChildHistory(String childId, String date) async {
      try {
        var data =
            await ChildHistoryRepository.apiGetChildHistory(childId, date);
        print('data getListChildHistory' + data.toString());

        Map<String, dynamic> jsonList = json.decode(data);
        childHistoryList = jsonList['data'];
        if (childHistoryList != null) {
          childHistoryListModel = childHistoryList
              .map((e) => ChildHistoryModel.fromJson(e))
              .toList();
          if (date != "") {
            childHistoryModel = childHistoryListModel[0];
          }
        } else {
          childHistoryModel = ChildHistoryModel();
        }
        notifyListeners();
      } catch (e) {
        print("error: " + e.toString());
      }
  }

  Future<bool> updateChildHistory(ChildHistoryModel childHistoryModel, String date) async {
    try {
      String result = await ChildHistoryRepository.apiUpdateChildHistory(childHistoryModel, date);
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

  void getListChildHistory() async {
    print('Chay 4');
    var childId = await storage.read(key: childIdKey);
    try {
      var data = await ChildHistoryRepository.apiGetChildHistory(childId, "");

      Map<String, dynamic> jsonList = json.decode(data);
      childHistoryList = jsonList['data'];

      if (childHistoryList != null) {
        childListHistoryChild =
            childHistoryList.map((e) => ChildHistoryModel.fromJson(e)).toList();
        if (childListHistoryChild.length > 1) {
          await childListHistoryChild.sort((a, b) => DateFormat("dd/MM/yyyy")
              .parse(a.date)
              .compareTo(DateFormat("dd/MM/yyyy").parse(b.date)));
        }
        notifyListeners();
      } else
        childListHistoryChild = <ChildHistoryModel>[];
    } catch (e) {
      print("error getListChildHistory: " + e.toString());
    }
  }
}
