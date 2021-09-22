import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mumbi_app/Constant/common_api.dart';
import 'package:mumbi_app/Model/reaction_model.dart';

class ReactionRepository{
  static Future<dynamic> apiGetPostReaction(num postId) async{
    var response = await http.get(
      Uri.parse("${GET_REACTION}").replace(
          queryParameters: {
            "PostId": postId.toString(),
          }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },);
    if(response.statusCode == 200){
      return response.body;
    }
  }

  static Future<dynamic> apiCountPostReaction(num postId) async{
    var response = await http.get(
      Uri.parse("${GET_REACTION}").replace(
          queryParameters:{
            "PostId": postId.toString(),
            "PageSize": "1",
          }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },);
    if(response.statusCode == 200){
      return response.body;
    }
  }

  static Future<dynamic> apiGetCommentReaction(num commentId) async{
    var response = await http.get(
      Uri.parse("${GET_REACTION}").replace(
          queryParameters: <String, String>{
            "CommentId": commentId.toString(),
          }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },);
    if(response.statusCode == 200){
      return response.body;
    }
  }

  static Future<dynamic> apiAddPostReaction(ReactionModel reactionModel) async{
    var response = await http.post(
        Uri.parse("${ADD_POST_REACTION}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(reactionModel.toJson()));
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  static Future<dynamic> apiAddCommentReaction(ReactionModel reactionModel) async{
    var response = await http.post(
        Uri.parse("${ADD_COMMENT_REACTION}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(reactionModel.toJson()));
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  static Future<dynamic> apiDeleteReaction(num id) async {
    var response = await http.delete(
      Uri.parse("${DELETE_REACTION}${id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    }
  }
}