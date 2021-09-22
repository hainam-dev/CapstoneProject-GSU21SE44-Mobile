import 'dart:convert';

import 'package:mumbi_app/Model/post_model.dart';
import 'package:mumbi_app/Model/reaction_model.dart';
import 'package:mumbi_app/Repository/comment_repository.dart';
import 'package:mumbi_app/Repository/post_repository.dart';
import 'package:mumbi_app/Repository/reaction_repository.dart';
import 'package:mumbi_app/ViewModel/user_viewmodel.dart';
import 'package:scoped_model/scoped_model.dart';

class CommunityViewModel extends Model{

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
    try{
      isLoading = true;
      var data = await PostRepository.apiGetCommunityPost(10);
      Map<String, dynamic> jsonList = json.decode(data);
      postList = jsonList['data'];
      postListModel = postList.map((e) => PostModel.fromJson(e)).toList();
      await postListModel.forEach((element) async{
        var dataReact = await ReactionRepository.apiCountPostReaction(element.id);
        element.totalReaction = json.decode(dataReact)['total'];
        var dataComment = await CommentRepository.apiCountPostComment(element.id);
        element.totalComment = json.decode(dataComment)['total'];
      });
      isLoading = false;
      notifyListeners();
    }catch (e){
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

  Future<bool> deleteCommunityPost(num id) async {
    try {
      String data = await PostRepository.apiDeletePost(id);
      return true;
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }

}