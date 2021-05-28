import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:mumbi_app/Model/article_model.dart';

class News{
  List<ArticleModel> news = [];

  Future<void> getNews() async{
    String url = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=68888c005ba246debc1e59efffe6d96b";

  var response = await http.get(Uri.parse(url));

  var jsonData = convert.jsonDecode(response.body) as Map<String, dynamic>;

  if(jsonData['status'] == "ok"){
    jsonData["articles"].forEach((element){

      if(element["urlToImage"] != null && element['description'] != null){
        ArticleModel articleModel = ArticleModel(
            title: element['title'],
          author: element["author"],
          description: element["description"],
          url: element["url"],
          urlToImage: element["urlToImage"],
          publishedAt:  element["publishedAt"],
          content: element["content"]
        );
        news.add(articleModel);
      }
    });
  }


  }
}