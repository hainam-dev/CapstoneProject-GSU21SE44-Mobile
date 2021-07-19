import 'dart:convert';

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

  List<dynamic> savedNewsList;
  List<SavedNewsModel> savedNewsListModel;

  Future<bool> saveNews(String newsId) async {
    SavedNewsModel savedNewsModel = SavedNewsModel();

    String momId = await UserViewModel.getUserID();
    savedNewsModel.momId = momId;
    savedNewsModel.newsId = newsId;
    try {
      String data = await SavedNewsRepository.apiSaveNews(savedNewsModel);
      notifyListeners();
      return true;
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }

  Future<bool> unsavedNews(num id) async {
    try {
      String data = await SavedNewsRepository.apiUnsavedNews(id);
      notifyListeners();
      return true;
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }

  void getSavedNewsByMom() async{
    String momId = await UserViewModel.getUserID();
    try{
      String data = await SavedNewsRepository.apiGetSavedNewsByMom(momId);
      Map<String, dynamic> jsonList = json.decode(data);
      savedNewsList = jsonList['data'];
      savedNewsListModel = savedNewsList.map((e) => SavedNewsModel.fromJson(e)).toList();
      savedNewsListModel.sort((a,b) => b.id.compareTo(a.id));
      notifyListeners();
    }catch(e){
      print("error: " + e.toString());
    }
  }



}