import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mumbi_app/Constant/common_api.dart';
import 'package:mumbi_app/Model/comment_model.dart';

class CommentRepository{
  static Future<dynamic> apiGetPostComment(num postId, num replyCommentId) async{
    var response = await http.get(
      Uri.parse("${GET_POST_COMMENT}").replace(
          queryParameters: <String, String>{
            "PostId": postId.toString(),
            "ReplyCommentId": replyCommentId.toString()
          }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },);
    if(response.statusCode == 200){
      return response.body;
    }
  }

  static Future<dynamic> apiAddPostComment(CommentModel commentModel) async{
    var response = await http.post(
        Uri.parse("${ADD_POST_COMMENT}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(commentModel.toJson()));
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  static Future<dynamic> apiAddReplyPostComment(CommentModel commentModel) async{
    var response = await http.post(
        Uri.parse("${ADD_REPLY_POST_COMMENT}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(commentModel.toJson()));
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  static Future<dynamic> apiUpdateComment(CommentModel commentModel) async {
    var response = await http.put(
        Uri.parse("${UPDATE_COMMENT}${commentModel.id}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(commentModel.toJson()));
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  static Future<dynamic> apiDeleteComment(num id) async {
    var response = await http.delete(
      Uri.parse("${DELETE_COMMENT}${id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    }
  }
}