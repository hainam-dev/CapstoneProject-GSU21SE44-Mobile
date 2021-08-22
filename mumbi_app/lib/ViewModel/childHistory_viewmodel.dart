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

  ChildHistoryModel _childHistoryModel;
  List<dynamic> _childHistoryList;
  List<ChildHistoryModel> _childHistoryListModel;
  List<ChildHistoryModel> _childListHistoryChild;

  ChildHistoryModel get childHistoryModel => _childHistoryModel;
  List<dynamic> get childHistoryList => _childHistoryList;
  List<ChildHistoryModel> get childHistoryListModel => _childHistoryListModel;
  List<ChildHistoryModel> get childListHistoryChild => _childListHistoryChild;

  void getChildHistory(String childId, String date) async {
    print('Chay cua Duy');
    if (_instance != null) {
      try {
        var data =
            await ChildHistoryRepository.apiGetChildHistory(childId, date);
        print('data getListChildHistory' + data.toString());

        Map<String, dynamic> jsonList = json.decode(data);
        _childHistoryList = jsonList['data'];
        if (childHistoryList != null) {
          _childHistoryListModel = childHistoryList
              .map((e) => ChildHistoryModel.fromJson(e))
              .toList();
          if (date != "") {
            _childHistoryModel = childHistoryListModel[0];
          }
        } else {
          _childHistoryModel = null;
        }
        notifyListeners();
      } catch (e) {
        print("error: " + e.toString());
      }
    }
  }

  Future<bool> updateChildHistory(
      String childId, ChildHistoryModel childHistoryModel, String date) async {
    try {
      String data = await ChildHistoryRepository.apiUpdateChildHistory(
          childId, childHistoryModel, date);
      return true;
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
        _childHistoryList = jsonList['data'];

        if (_childHistoryList != null) {
          _childListHistoryChild = childHistoryList
              .map((e) => ChildHistoryModel.fromJson(e))
              .toList();
          if (_childListHistoryChild.length > 1) {
            await _childListHistoryChild.sort((a, b) => DateFormat("dd/MM/yyyy")
                .parse(a.date)
                .compareTo(DateFormat("dd/MM/yyyy").parse(b.date)));
          }
          notifyListeners();
        } else
          _childListHistoryChild = <ChildHistoryModel>[];
      } catch (e) {
        print("error getListChildHistory: " + e.toString());
      }
    }
}
