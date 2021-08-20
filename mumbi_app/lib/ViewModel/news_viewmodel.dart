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
  List<NewsModel> newsListModel;

  void getAllNews() async {
    try {
      String data = await NewsRepository.apiGetAllNews();
      Map<String, dynamic> jsonList = json.decode(data);
      newsList = jsonList['data'];
      newsListModel = newsList.map((e) => NewsModel.fromJson(e)).toList();
      newsListModel.sort((a, b) => b.createTime.compareTo(a.createTime));
      notifyListeners();
    } catch (e) {
      print("error: " + e.toString());
    }
  }
}
