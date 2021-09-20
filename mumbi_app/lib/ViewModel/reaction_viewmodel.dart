import 'dart:convert';

import 'package:mumbi_app/Model/comment_model.dart';
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

  num totalReaction;
  List<dynamic> reactionList;
  List<ReactionModel> reactionListModel;

  void getPostReaction(num postId, num commentId) async {
    try{
      var data = await ReactionRepository.apiGetPostReaction(postId);
      Map<String, dynamic> jsonList = json.decode(data);
      totalReaction = jsonList['total'];
      reactionList = jsonList['data'];
      if(reactionList != null);
      reactionListModel = reactionListModel.map((e) => ReactionModel.fromJson(e)).toList();
      notifyListeners();
    }catch (e){
      print("error: " + e.toString());
    }
  }

  Future<bool> addPostReaction(ReactionModel reactionModel) async {
    String userId = await UserViewModel.getUserID();
    reactionModel.userId = userId;
    try {
      String data = await ReactionRepository.apiAddPostReaction(reactionModel);
      notifyListeners();
      return true;
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }

  Future<bool> addCommentReaction(ReactionModel reactionModel) async {
    String userId = await UserViewModel.getUserID();
    reactionModel.userId = userId;
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