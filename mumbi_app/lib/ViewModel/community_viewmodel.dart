import 'dart:convert';

import 'package:mumbi_app/Model/diary_model.dart';
import 'package:mumbi_app/Repository/diary_repository.dart';
import 'package:scoped_model/scoped_model.dart';

class CommunityViewModel extends Model{

  static CommunityViewModel _instance;

  static CommunityViewModel getInstance() {
    if (_instance == null) {
      _instance = CommunityViewModel();
    }
    return _instance;
  }

  static void destroyInstance() {
    _instance = null;
  }

  List<dynamic> diaryList;
  List<DiaryModel> publicDiaryListModel;

  void getPublicDiary() async {
    try{
      var data = await DiaryRepository.apiGetPublicDiary();
      Map<String, dynamic> jsonList = json.decode(data);
      diaryList = jsonList['data'];
      publicDiaryListModel = diaryList.map((e) => DiaryModel.fromJson(e)).toList();
      publicDiaryListModel.sort((a,b) => b.createTime.compareTo(a.createTime));
      notifyListeners();
    }catch (e){
      print("error: " + e.toString());
    }
  }

}