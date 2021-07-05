import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:mumbi_app/Model/article_model.dart';

class News{
  List<ArticleModel> news = [];

  Future<void> getNews() async{

    try{
      String url = "http://mumbicapstone-dev.ap-southeast-1.elasticbeanstalk.com/api/Guidebooks/GetAllGuidebook";

      var response = await http.get(Uri.parse(url));

      var jsonData = convert.jsonDecode(response.body) as Map<String, dynamic>;

      if(jsonData['succeeded'] == true){
        jsonData["data"].forEach((element){

          if(element["title"] != null && element['guidebookContent'] != null){
            ArticleModel articleModel = ArticleModel(
                id: element['id'],
                title: element['title'],
                createdBy: element["createdBy"],
                createdTime: element["createdTime"],
                imageURL: element["imageURL"],
                guidebookContent: element["guidebookContent"],
                status: false
            );
            news.add(articleModel);
          }
        });
      }

    } catch(e){
      print(e.toString());
    }
  }
}