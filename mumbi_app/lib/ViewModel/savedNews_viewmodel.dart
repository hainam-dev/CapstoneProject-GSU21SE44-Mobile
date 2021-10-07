import 'dart:convert';

import 'package:mumbi_app/Model/news_model.dart';
import 'package:mumbi_app/Model/savedNews_model.dart';
import 'package:mumbi_app/Repository/savedNews_Repository.dart';
import 'package:mumbi_app/ViewModel/user_viewmodel.dart';
import 'package:scoped_model/scoped_model.dart';

class SavedNewsViewModel extends Model{

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

  SavedNewsModel savedNewsModel;
  List<dynamic> savedNewsList;
  bool isLoading;
  List<SavedNewsModel> savedNewsListModel;

  Future<bool> saveNews(String newsId) async {
    SavedNewsModel savedNewsModel = new SavedNewsModel();

    String momId = await UserViewModel.getUserID();
    savedNewsModel.momId = momId;
    savedNewsModel.newsId = newsId;
    try {
      String data = await SavedNewsRepository.apiSaveNews(savedNewsModel);
      return true;
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }

  Future<bool> unsavedNews(num id) async {
    try {
      String data = await SavedNewsRepository.apiUnsavedNews(id);
      return true;
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }

  void getSavedNewsByMom() async{
      String momId = await UserViewModel.getUserID();
      isLoading = true;
      try{
        String data = await SavedNewsRepository.apiGetSavedNewsByMom(momId);
        Map<String, dynamic> jsonList = json.decode(data);
        savedNewsList = jsonList['data'];
        if(savedNewsList != null){
          savedNewsListModel = savedNewsList.map((e) => SavedNewsModel.fromJson(e)).toList();
          savedNewsListModel.sort((a,b) => b.id.compareTo(a.id));
        }
        isLoading = false;
        notifyListeners();
      }catch(e){
        print("error: " + e.toString());
      }
  }

  void checkSavedNews(String newsId) async {
    try{
      isLoading = true;
      String userId = await UserViewModel.getUserID();
      var checkSaved = await SavedNewsRepository.apiCheckSavedNews(userId, newsId);
      List checkSavedJsonList = json.decode(checkSaved)['data'];
      savedNewsModel = new SavedNewsModel();
      if(checkSavedJsonList != null){
        List savedModelList = checkSavedJsonList.map((e) => SavedNewsModel.fromJson(e)).toList();
        savedNewsModel.id = savedModelList[0].id;
      }else{
        savedNewsModel.id = 0;
      }
      isLoading = false;
      notifyListeners();
    }catch(e){
      print("error: " + e.toString());
    }
  }
}