import 'dart:convert';

import 'package:mumbi_app/Model/comment_model.dart';
import 'package:mumbi_app/Model/post_model.dart';
import 'package:mumbi_app/Repository/comment_repository.dart';
import 'package:mumbi_app/ViewModel/reaction_viewmodel.dart';
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
  List<dynamic> commentList;
  List<CommentModel> commentListModel;

  void getPostComment(PostModel postModel) async {
    try{
      isLoading = true;
      var data = await CommentRepository.apiGetPostComment(postModel.id);
      Map<String, dynamic> jsonList = json.decode(data);
      commentList = jsonList['data'];
      if(commentList != null){
        commentListModel = commentList.map((e) => CommentModel.fromJson(e)).toList();
        await Future.forEach(commentListModel, (commentModel) async {
          await ReactionViewModel().countCommentReaction(commentModel);
          await CommentViewModel().countReply(commentModel);
          await ReactionViewModel().checkCommentReaction(commentModel);
        });
      }else{
        commentListModel = new List();
      }
      isLoading = false;
      notifyListeners();
    }catch (e){
      print("error: " + e.toString());
    }
  }

  void getReplyPostComment(CommentModel commentModel) async {
    try{
      isLoading = true;
      var data = await CommentRepository.apiGetReplyPostComment(commentModel.replyCommentId);
      Map<String, dynamic> jsonList = json.decode(data);
      commentList = jsonList['data'];
      if(commentList != null){
        commentListModel = commentList.map((e) => CommentModel.fromJson(e)).toList();
        await Future.forEach(commentListModel, (commentModel) async {
          await ReactionViewModel().countCommentReaction(commentModel);
          await ReactionViewModel().checkCommentReaction(commentModel);
        });
      }else{
        commentListModel = new List();
      }
      isLoading = false;
      notifyListeners();
    }catch (e){
      print("error: " + e.toString());
    }
  }

  void countCommentPost(PostModel postModel) async {
    var countComment = await CommentRepository.apiCountPostComment(postModel.id);
    postModel.totalComment = json.decode(countComment)['total'];
  }

  void countReply(CommentModel commentModel) async {
    var countReply = await CommentRepository.apiCountReply(commentModel.id);
    commentModel.totalReply = json.decode(countReply)['total'];
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