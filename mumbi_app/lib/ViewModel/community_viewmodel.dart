import 'dart:convert';

import 'package:mumbi_app/Model/post_model.dart';
import 'package:mumbi_app/Repository/post_repository.dart';
import 'package:mumbi_app/ViewModel/comment_viewmodel.dart';
import 'package:mumbi_app/ViewModel/reaction_viewmodel.dart';
import 'package:mumbi_app/ViewModel/user_viewmodel.dart';
import 'package:scoped_model/scoped_model.dart';

class CommunityViewModel extends Model {
  static CommunityViewModel _instance;

  static CommunityViewModel getInstance() {
    if (_instance == null) {
      _instance = CommunityViewModel();
    }
    return _instance;
  }

  static void destroyInstance() {
    _instance = null;
  }

  bool isLoading = true;
  List<dynamic> postList;
  List<PostModel> postListModel;

  void getCommunityPost() async {
    try {
      isLoading = true;
      var data = await PostRepository.apiGetCommunityPost(3);
      Map<String, dynamic> jsonList = json.decode(data);
      postList = jsonList['data'];
      postListModel = postList.map((e) => PostModel.fromJson(e)).toList();
      await Future.forEach(postListModel, (postModel) async {
        await ReactionViewModel().countPostReaction(postModel);
        await CommentViewModel().countCommentPost(postModel);
        await ReactionViewModel().checkPostReaction(postModel);
      });
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      print("error: " + e.toString());
    }
  }

  Future<bool> addCommunityPost(PostModel postModel) async {
    String userId = await UserViewModel.getUserID();
    postModel.userId = userId;
    try {
      String data = await PostRepository.apiAddCommunityPost(postModel);
      notifyListeners();
      return true;
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }

  Future<bool> updateCommunityPost(PostModel postModel) async {
    try {
      String data = await PostRepository.apiUpdateCommunityPost(postModel);
      return true;
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }

  Future<bool> deleteCommunityPost(PostModel postModel) async {
    try {
      String data = await PostRepository.apiDeletePost(postModel.id);
      return true;
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }
}
