import 'dart:convert';

import 'package:mumbi_app/Model/diary_model.dart';
import 'package:mumbi_app/Repository/diary_repository.dart';
import 'package:mumbi_app/ViewModel/user_viewmodel.dart';
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
        if(diaryList != null){
          childDiaryListModel = diaryList.map((e) => DiaryModel.fromJson(e)).toList();
          childDiaryListModel.sort((a,b) => b.createTime.compareTo(a.createTime));
        }
        notifyListeners();
      }catch (e){
        print("error: " + e.toString());
      }
  }

  Future<bool> addDiary(DiaryModel diaryModel) async {
    String userId = await UserViewModel.getUserID();
    diaryModel.createdBy = userId;
    try {
      String result = await DiaryRepository.apiAddDiary(diaryModel);
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

  Future<bool> updateDiary(DiaryModel diaryModel) async {
    try {
      String result = await DiaryRepository.apiUpdateDiary(diaryModel);
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

  Future<bool> deleteDiary(num id) async {
    try {
      String result = await DiaryRepository.apiDeleteDiary(id);
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