import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mumbi_app/Constant/common_api.dart';
import 'package:mumbi_app/Model/post_model.dart';

class PostRepository{
  static Future<dynamic> apiGetCommunityPost() async{
    var response = await http.get(
      Uri.parse("${GET_COMMUNITY_POST}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },);
    if(response.statusCode == 200){
      return response.body;
    }
  }

  static Future<dynamic> apiAddCommunityPost(PostModel postModel) async{
    var response = await http.post(
        Uri.parse("${ADD_COMMUNITY_POST}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(postModel.toJson()));
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  static Future<dynamic> apiUpdateCommunityPost(PostModel postModel) async {
    var response = await http.put(
        Uri.parse("${UPDATE_COMMUNITY_POST}${postModel.id}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(postModel.toJson()));
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  static Future<dynamic> apiDeletePost(num id) async {
    var response = await http.put(
      Uri.parse("${DELETE_COMMUNITY_POST}${id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    }
  }
}