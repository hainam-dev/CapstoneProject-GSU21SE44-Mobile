import 'dart:convert';
import 'package:mumbi_app/modules/news/models/news_model.dart';
import 'package:mumbi_app/modules/news/repositories/news_repository.dart';
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

  num pageSize = 10;
  num currentPage;
  num totalPage;
  bool isLoading = true;
  List<NewsModel> newsListModel;

  void getNews() async {
    try {
      isLoading = true;
      String data = await NewsRepository.apiGetNews(1);
      Map<String, dynamic> jsonList = json.decode(data);
      List<dynamic> newsList = jsonList['data'];
      if (newsList != null) {
        newsListModel = newsList.map((e) => NewsModel.fromJson(e)).toList();
      } else {
        newsListModel = null;
      }
      currentPage = jsonList['pageNumber'];
      totalPage = jsonList['total'] / pageSize;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print("error: " + e.toString());
    }
  }

  void getMoreNews() async {
    try {
      if (currentPage < totalPage) {
        isLoading = true;
        String data = await NewsRepository.apiGetNews(++currentPage);
        Map<String, dynamic> jsonList = json.decode(data);
        List<dynamic> newsList = jsonList['data'];
        if (newsList != null) {
          List<NewsModel> moreNewsListModel =
              newsList.map((e) => NewsModel.fromJson(e)).toList();
          currentPage = jsonList['pageNumber'];
          totalPage = jsonList['total'] / pageSize;
          newsListModel.addAll(moreNewsListModel);
        }
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      print("error: " + e.toString());
    }
  }

  void getRelatedNews(num typeId, String newsId) async {
    try {
      isLoading = true;
      String data = await NewsRepository.apiGetNews(1, typeId);
      Map<String, dynamic> jsonList = json.decode(data);
      List<dynamic> newsList = jsonList['data'];
      if (newsList != null) {
        newsListModel = newsList.map((e) => NewsModel.fromJson(e)).toList();
        for (int i = newsListModel.length - 1; i >= 0; i--) {
          NewsModel newsModel = newsListModel[i];
          if (newsModel.newsId == newsId) {
            newsListModel.removeAt(i);
            if (newsListModel.length == 0) {
              newsListModel = null;
            }
            break;
          }
        }
      } else {
        newsListModel = null;
      }
      notifyListeners();
      isLoading = false;
    } catch (e) {
      print("error: " + e.toString());
    }
  }
}
