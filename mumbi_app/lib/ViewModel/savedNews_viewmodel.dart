import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mumbi_app/Model/news_model.dart';
import 'package:mumbi_app/Model/savedNews_model.dart';
import 'package:mumbi_app/Repository/news_repository.dart';
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

  void getSavedNewsByMom() async{
    String momId = await UserViewModel.getUserID();
    try{
      String data = await NewsRepository.apiGetSavedNewsByMom(momId);
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