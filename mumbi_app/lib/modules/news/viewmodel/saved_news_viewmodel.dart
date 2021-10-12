import 'dart:convert';
import 'package:mumbi_app/modules/news/models/saved_news_model.dart';
import 'package:mumbi_app/modules/news/repositories/saved_news_repository.dart';
import 'package:mumbi_app/core/auth/login/viewmodel/user_viewmodel.dart';
import 'package:scoped_model/scoped_model.dart';

class SavedNewsViewModel extends Model {
  static SavedNewsViewModel _instance;

  static SavedNewsViewModel getInstance() {
    if (_instance == null) {
      _instance = SavedNewsViewModel();
    }
    return _instance;
  }

  static void destroyInstance() {
    _instance = null;
  }

  num pageSize = 10;
  num currentPage;
  num totalPage;
  SavedNewsModel savedNewsModel;
  bool isLoading = true;
  List<SavedNewsModel> savedNewsListModel;

  void getSavedNews() async {
    try {
      isLoading = true;
      String momId = await UserViewModel.getUserID();
      String data = await SavedNewsRepository.apiGetSavedNews(momId, 1);
      Map<String, dynamic> jsonList = json.decode(data);
      List<dynamic> savedNewsList = jsonList['data'];
      if (savedNewsList != null) {
        savedNewsListModel =
            savedNewsList.map((e) => SavedNewsModel.fromJson(e)).toList();
      } else {
        savedNewsModel = null;
      }
      currentPage = jsonList['pageNumber'];
      totalPage = jsonList['total'] / pageSize;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print("error: " + e.toString());
    }
  }

  void getMoreSavedNews() async {
    try {
      if (currentPage < totalPage) {
        isLoading = true;
        String momId = await UserViewModel.getUserID();
        String data =
            await SavedNewsRepository.apiGetSavedNews(momId, ++currentPage);
        Map<String, dynamic> jsonList = json.decode(data);
        List<dynamic> savedNewsList = jsonList['data'];
        if (savedNewsList != null) {
          List<SavedNewsModel> moreSavedNewsListModel =
              savedNewsList.map((e) => SavedNewsModel.fromJson(e)).toList();
          currentPage = jsonList['pageNumber'];
          totalPage = jsonList['total'] / pageSize;
          savedNewsListModel.addAll(moreSavedNewsListModel);
        }
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      print("error: " + e.toString());
    }
  }

  void checkSavedNews(String newsId) async {
    try {
      isLoading = true;
      String userId = await UserViewModel.getUserID();
      var checkSaved =
          await SavedNewsRepository.apiCheckSavedNews(userId, newsId);
      List<dynamic> checkSavedJsonList = json.decode(checkSaved)['data'];
      savedNewsModel = new SavedNewsModel();
      if (checkSavedJsonList != null) {
        List savedModelList =
            checkSavedJsonList.map((e) => SavedNewsModel.fromJson(e)).toList();
        savedNewsModel.id = savedModelList[0].id;
      } else {
        savedNewsModel.id = 0;
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print("error: " + e.toString());
    }
  }

  Future<bool> saveNews(String newsId) async {
    try {
      SavedNewsModel savedNewsModel = new SavedNewsModel();
      String momId = await UserViewModel.getUserID();
      savedNewsModel.momId = momId;
      savedNewsModel.newsId = newsId;

      String result = await SavedNewsRepository.apiSaveNews(savedNewsModel);
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

  Future<bool> unsavedNews(num id) async {
    try {
      String result = await SavedNewsRepository.apiUnsavedNews(id);
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
