import 'dart:convert';

import 'package:mumbi_app/modules/diary/models/diary_model.dart';
import 'package:mumbi_app/modules/diary/repositories/diary_repository.dart';
import 'package:mumbi_app/core/auth/login/viewmodel/user_viewmodel.dart';
import 'package:scoped_model/scoped_model.dart';

class DiaryViewModel extends Model {
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

  num pageSize = 10;
  num currentPage;
  num totalPage;
  List<DiaryModel> childDiaryListModel;

  void getChildDiary(String id) async {
    try {
      var data = await DiaryRepository.apiGetChildDiary(id, 1);
      Map<String, dynamic> jsonList = json.decode(data);
      List<dynamic> diaryList = jsonList['data'];
      if (diaryList != null) {
        childDiaryListModel =
            diaryList.map((e) => DiaryModel.fromJson(e)).toList();
      }
      currentPage = jsonList['pageNumber'];
      totalPage = jsonList['total'] / pageSize;
      notifyListeners();
    } catch (e) {
      print("error: " + e.toString());
    }
  }

  void getMoreChildDiary(String id) async {
    try {
      if (currentPage < totalPage) {
        var data = await DiaryRepository.apiGetChildDiary(id, ++currentPage);
        Map<String, dynamic> jsonList = json.decode(data);
        List<dynamic> diaryList = jsonList['data'];
        if (diaryList != null) {
          List<DiaryModel> moreChildDiaryListModel =
              diaryList.map((e) => DiaryModel.fromJson(e)).toList();
          currentPage = jsonList['pageNumber'];
          totalPage = jsonList['total'] / pageSize;
          await childDiaryListModel.addAll(moreChildDiaryListModel);
        }
        notifyListeners();
      }
    } catch (e) {
      print("error: " + e.toString());
    }
  }

  Future<bool> addDiary(DiaryModel diaryModel) async {
    String userId = await UserViewModel.getUserID();
    diaryModel.createdBy = userId;
    try {
      String result = await DiaryRepository.apiAddDiary(diaryModel);
      if (result != null) {
        return true;
      } else {
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
      if (result != null) {
        return true;
      } else {
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
      if (result != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }
}
