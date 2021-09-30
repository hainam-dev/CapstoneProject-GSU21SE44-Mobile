import 'dart:convert';
import 'package:mumbi_app/Model/news_model.dart';
import 'package:mumbi_app/Repository/news_repository.dart';
import 'package:scoped_model/scoped_model.dart';

class NewsViewModel extends Model {
  static NewsViewModel _instance;

  static NewsViewModel getInstance() {
    if (_instance == null) {
      _instance = NewsViewModel();
    }
    return _instance;
  }

  static void destroyInstance() {
    _instance = null;
  }

  NewsModel newsModel;

  List<dynamic> newsList;
  bool loadingNewsListModel;
  List<NewsModel> newsListModel;

  void getAllNews() async {
    loadingNewsListModel = true;
    try {
      String data = await NewsRepository.apiGetAllNews();
      Map<String, dynamic> jsonList = json.decode(data);
      newsList = jsonList['data'];
      newsListModel = newsList.map((e) => NewsModel.fromJson(e)).toList();
      notifyListeners();
      loadingNewsListModel = false;
    } catch (e) {
      print("error: " + e.toString());
    }
  }

  void getNewsByType(NewsModel newsModel) async {
    loadingNewsListModel = true;
    try {
      String data = await NewsRepository.apiGetNewsByType(newsModel.typeId);
      Map<String, dynamic> jsonList = json.decode(data);
      newsList = jsonList['data'];
      if(newsList != null){
        newsListModel = newsList.map((e) => NewsModel.fromJson(e)).toList();
        for(int i = newsListModel.length - 1; i >= 0 ; i--){
          NewsModel newsModelFromList = newsListModel[i];
          if(newsModelFromList.newsId == newsModel.newsId){
            newsListModel.removeAt(i);
            break;
          }
        }
      }else{
        newsListModel = null;
      }
      notifyListeners();
      loadingNewsListModel = false;
    } catch (e) {
      print("error: " + e.toString());
    }
  }
}
