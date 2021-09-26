import 'dart:convert';

import 'package:comment_tree/data/comment.dart';
import 'package:mumbi_app/Model/comment_model.dart';
import 'package:mumbi_app/Model/post_model.dart';
import 'package:mumbi_app/Model/reaction_model.dart';
import 'package:mumbi_app/Repository/comment_repository.dart';
import 'package:mumbi_app/Repository/reaction_repository.dart';
import 'package:mumbi_app/ViewModel/user_viewmodel.dart';
import 'package:scoped_model/scoped_model.dart';

class ReactionViewModel extends Model{

  static ReactionViewModel _instance;

  static ReactionViewModel getInstance() {
    if (_instance == null) {
      _instance = ReactionViewModel();
    }
    return _instance;
  }

  static void destroyInstance() {
    _instance = null;
  }

  List<dynamic> reactionList;
  List<ReactionModel> reactionListModel;

  void getPostReaction(num postId) async {
    try{
      var data = await ReactionRepository.apiGetPostReaction(postId);
      Map<String, dynamic> jsonList = json.decode(data);
      reactionList = jsonList['data'];
      if(reactionList != null);
      reactionListModel = reactionList.map((e) => ReactionModel.fromJson(e)).toList();
      notifyListeners();
    }catch (e){
      print("error: " + e.toString());
    }
  }

  void countPostReaction(PostModel postModel) async {
    var countReact = await ReactionRepository.apiCountPostReaction(postModel.id);
    postModel.totalReaction = json.decode(countReact)['total'];
  }

  void checkPostReaction(PostModel postModel) async {
    String userId = await UserViewModel.getUserID();
    var checkReact = await ReactionRepository.apiCheckPostReaction(userId, postModel.id);
    List checkReactJsonList = json.decode(checkReact)['data'];
    if(checkReactJsonList != null){
      List reactionModelList = checkReactJsonList.map((e) => ReactionModel.fromJson(e)).toList();
      postModel.idReaction = reactionModelList[0].id;
    }else{
      postModel.idReaction = 0;
    }
  }

  void countCommentReaction(CommentModel commentModel) async {
    var countReact = await ReactionRepository.apiCountCommentReaction(commentModel.id);
    commentModel.totalReaction = json.decode(countReact)['total'];
  }

  void checkCommentReaction(CommentModel commentModel) async {
    String userId = await UserViewModel.getUserID();
    var checkReact = await ReactionRepository.apiCheckCommentReaction(userId, commentModel.id);
    List checkReactJsonList = json.decode(checkReact)['data'];
    if(checkReactJsonList != null){
      List reactionModelList = checkReactJsonList.map((e) => ReactionModel.fromJson(e)).toList();
      commentModel.idReaction = reactionModelList[0].id;
    }else{
      commentModel.idReaction = 0;
    }
  }

  Future<bool> addPostReaction(num postId) async {
    String userId = await UserViewModel.getUserID();
    ReactionModel reactionModel = new ReactionModel();
    reactionModel.userId = userId;
    reactionModel.postId = postId;
    reactionModel.typeId = 1;
    try {
      String data = await ReactionRepository.apiAddPostReaction(reactionModel);
      notifyListeners();
      return true;
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }

  Future<bool> addCommentReaction(num commentId) async {
    String userId = await UserViewModel.getUserID();
    ReactionModel reactionModel = new ReactionModel();
    reactionModel.userId = userId;
    reactionModel.commentId = commentId;
    reactionModel.typeId = 1;
    try {
      String data = await ReactionRepository.apiAddCommentReaction(reactionModel);
      notifyListeners();
      return true;
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }

  Future<bool> deleteReaction(num id) async {
    try {
      String data = await ReactionRepository.apiDeleteReaction(id);
      return true;
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }

}