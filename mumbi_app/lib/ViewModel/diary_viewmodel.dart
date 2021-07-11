import 'dart:convert';

import 'package:mumbi_app/Model/diary_model.dart';
import 'package:mumbi_app/Repository/diary_repository.dart';
import 'package:scoped_model/scoped_model.dart';

class DiaryViewModel extends Model{

  static DiaryViewModel _instance;

  static DiaryViewModel getInstance() {
    if (_instance == null) {
      _instance = DiaryViewModel();
    }
    return _instance;
  }

  static void destroyInstance() {
    _instance = null;
  }

  List<dynamic> diaryList;
  List<DiaryModel> childDiaryListModel;

  void getChildDiary(String id) async {
    try{
      var data = await DiaryRepository.apiGetChildDiary(id);
      Map<String, dynamic> jsonList = json.decode(data);
      diaryList = jsonList['data'];
      childDiaryListModel = diaryList.map((e) => DiaryModel.fromJson(e)).toList();
      childDiaryListModel.sort((a,b) => b.createTime.compareTo(a.createTime));
      notifyListeners();
    }catch (e){
      print("error: " + e.toString());
    }
  }

  Future<bool> deleteDiary(String id) async {
    try {
      String data = await DiaryRepository.apiDeleteDiary(id);
      destroyInstance();
      return true;
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }
}