import 'dart:convert';

import 'package:mumbi_app/Model/post_model.dart';
import 'package:mumbi_app/Model/reaction_model.dart';
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

  List<dynamic> postList;
  List<PostModel> postListModel;

  void getCommunityPost() async {
    try{
      var data = await PostRepository.apiGetCommunityPost();
      Map<String, dynamic> jsonList = json.decode(data);
      postList = jsonList['data'];
      postListModel = postList.map((e) => PostModel.fromJson(e)).toList();
      //var dataReact = await ReactionRepository.apiGetPostReaction(postListModel.single.id);
      //postListModel.single.totalReaction = json.decode(dataReact)['total'];
      notifyListeners();
    }catch (e){
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