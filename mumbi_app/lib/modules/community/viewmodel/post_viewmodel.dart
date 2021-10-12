import 'dart:convert';

import 'package:mumbi_app/modules/community/model/post_model.dart';
import 'package:mumbi_app/modules/community/repositories/post_repository.dart';
import 'package:mumbi_app/core/auth/login/viewmodel/user_viewmodel.dart';
import 'package:mumbi_app/modules/community/viewmodel/reaction_viewmodel.dart';
import 'package:scoped_model/scoped_model.dart';

class PostViewModel extends Model {
  static PostViewModel _instance;

  static PostViewModel getInstance() {
    if (_instance == null) {
      _instance = PostViewModel();
    }
    return _instance;
  }

  static void destroyInstance() {
    _instance = null;
  }

  num pageSize = 3;
  num currentPage;
  num totalPage;
  bool isLoading = true;
  List<dynamic> postList;
  List<PostModel> postListModel;

  void getCommunityPost() async {
    try {
      isLoading = true;
      var data = await PostRepository.apiGetCommunityPost(pageSize, 1);
      Map<String, dynamic> jsonList = json.decode(data);
      postList = jsonList['data'];
      if (postList != null) {
        postListModel = postList.map((e) => PostModel.fromJson(e)).toList();
        await Future.forEach(postListModel, (postModel) async {
          await ReactionViewModel().checkPostReaction(postModel);
        });
      }
      currentPage = jsonList['pageNumber'];
      totalPage = jsonList['total'] / pageSize;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      print("error: " + e.toString());
    }
  }

  void getMoreCommunityPost() async {
    try {
      if (currentPage < totalPage) {
        isLoading = true;
        var data =
            await PostRepository.apiGetCommunityPost(pageSize, ++currentPage);
        Map<String, dynamic> jsonList = json.decode(data);
        postList = jsonList['data'];
        if (postList != null) {
          List<PostModel> morePostListModel =
              postList.map((e) => PostModel.fromJson(e)).toList();
          currentPage = jsonList['pageNumber'];
          totalPage = jsonList['total'] / pageSize;
          await Future.forEach(morePostListModel, (postModel) async {
            await ReactionViewModel().checkPostReaction(postModel);
          });
          await postListModel.addAll(morePostListModel);
        }
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      print("error: " + e.toString());
    }
  }

  Future<bool> addCommunityPost(PostModel postModel) async {
    String userId = await UserViewModel.getUserID();
    postModel.userId = userId;
    try {
      String result = await PostRepository.apiAddCommunityPost(postModel);
      if (result != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }

  Future<bool> updateCommunityPost(PostModel postModel) async {
    try {
      String result = await PostRepository.apiUpdateCommunityPost(postModel);
      if (result != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }

  Future<bool> deleteCommunityPost(PostModel postModel) async {
    try {
      String result = await PostRepository.apiDeletePost(postModel.id);
      if (result != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("error: " + e.toString());
    }
    return false;
  }
}
