import 'dart:convert';

import 'package:mumbi_app/Model/comment_model.dart';
import 'package:mumbi_app/Repository/comment_repository.dart';
import 'package:mumbi_app/ViewModel/user_viewmodel.dart';
import 'package:scoped_model/scoped_model.dart';

class CommentViewModel extends Model{

  static CommentViewModel _instance;

  static CommentViewModel getInstance() {
    if (_instance == null) {
      _instance = CommentViewModel();
    }
    return _instance;
  }

  static void destroyInstance() {
    _instance = null;
  }

  bool isLoading;
  num totalComment;
  List<dynamic> commentList;
  List<CommentModel> commentListModel;

  void getPostComment(num postId) async {
    try{
      isLoading = false;
      var data = await CommentRepository.apiGetPostComment(postId);
      Map<String, dynamic> jsonList = json.decode(data);
      totalComment = jsonList['total'];
      commentList = jsonList['data'];
      if(commentList != null){
        commentListModel = commentList.map((e) => CommentModel.fromJson(e)).toList();
      }else{
        commentListModel = null;
      }
      notifyListeners();
    }catch (e){
      print("error: " + e.toString());
    }
  }

  Future<bool> addPostComment(CommentModel commentModel) async {
    String userId = await UserViewModel.getUserID();
    commentModel.userId = userId;
    try {
      String data = await CommentRepository.apiAddPostComment(commentModel);
      notifyListeners();
      return true;
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }

  Future<bool> addReplyPostComment(CommentModel commentModel) async {
    String userId = await UserViewModel.getUserID();
    commentModel.userId = userId;
    try {
      String data = await CommentRepository.apiAddReplyPostComment(commentModel);
      notifyListeners();
      return true;
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }

  Future<bool> updateComment(CommentModel commentModel) async {
    try {
      String data = await CommentRepository.apiUpdateComment(commentModel);
      return true;
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }

  Future<bool> deleteComment(num id) async {
    try {
      String data = await CommentRepository.apiDeleteComment(id);
      return true;
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }

}