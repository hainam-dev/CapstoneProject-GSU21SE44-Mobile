import 'dart:convert';

import 'package:mumbi_app/modules/community/model/comment_model.dart';
import 'package:mumbi_app/modules/community/model/post_model.dart';
import 'package:mumbi_app/modules/community/repositories/comment_repository.dart';
import 'package:mumbi_app/core/auth/login/viewmodel/user_viewmodel.dart';
import 'package:mumbi_app/modules/community/viewmodel/reaction_viewmodel.dart';
import 'package:scoped_model/scoped_model.dart';

class CommentViewModel extends Model {
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

  num pageSize = 10;
  num currentPage;
  num totalPage;
  bool isLoading;
  List<CommentModel> commentListModel;

  void getPostComment(PostModel postModel) async {
    try {
      isLoading = true;
      var data = await CommentRepository.apiGetPostComment(postModel.id, 1);
      Map<String, dynamic> jsonList = json.decode(data);
      List<dynamic> commentList = jsonList['data'];
      if (commentList != null) {
        commentListModel =
            commentList.map((e) => CommentModel.fromJson(e)).toList();
        await Future.forEach(commentListModel, (commentModel) async {
          await ReactionViewModel().checkCommentReaction(commentModel);
        });
      } else {
        commentListModel = null;
      }
      currentPage = jsonList['pageNumber'];
      totalPage = jsonList['total'] / pageSize;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print("error: " + e.toString());
    }
  }

  void getMorePostComment(PostModel postModel) async {
    try {
      if (currentPage < totalPage) {
        isLoading = true;
        var data = await CommentRepository.apiGetPostComment(
            postModel.id, ++currentPage);
        Map<String, dynamic> jsonList = json.decode(data);
        List<dynamic> commentList = jsonList['data'];
        if (commentList != null) {
          List<CommentModel> moreCommentListModel =
              commentList.map((e) => CommentModel.fromJson(e)).toList();
          currentPage = jsonList['pageNumber'];
          totalPage = jsonList['total'] / pageSize;
          await Future.forEach(moreCommentListModel, (commentModel) async {
            await ReactionViewModel().checkCommentReaction(commentModel);
          });
          await commentListModel.addAll(moreCommentListModel);
        }
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      print("error: " + e.toString());
    }
  }

  void getReplyPostComment(CommentModel commentModel) async {
    try {
      isLoading = true;
      var data = await CommentRepository.apiGetReplyPostComment(
          commentModel.replyCommentId, 1);
      Map<String, dynamic> jsonList = json.decode(data);
      List<dynamic> commentList = jsonList['data'];
      if (commentList != null) {
        commentListModel =
            commentList.map((e) => CommentModel.fromJson(e)).toList();
        await Future.forEach(commentListModel, (commentModel) async {
          await ReactionViewModel().checkCommentReaction(commentModel);
        });
      } else {
        commentListModel = null;
      }
      currentPage = jsonList['pageNumber'];
      totalPage = jsonList['total'] / pageSize;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print("error: " + e.toString());
    }
  }

  void getMoreReplyPostComment(CommentModel commentModel) async {
    try {
      if (currentPage < totalPage) {
        isLoading = true;
        var data = await CommentRepository.apiGetReplyPostComment(
            commentModel.replyCommentId, ++currentPage);
        Map<String, dynamic> jsonList = json.decode(data);
        List<dynamic> commentList = jsonList['data'];
        if (commentList != null) {
          List<CommentModel> moreCommentListModel =
              commentList.map((e) => CommentModel.fromJson(e)).toList();
          currentPage = jsonList['pageNumber'];
          totalPage = jsonList['total'] / pageSize;
          await Future.forEach(moreCommentListModel, (commentModel) async {
            await ReactionViewModel().checkCommentReaction(commentModel);
          });
          await commentListModel.addAll(moreCommentListModel);
        }
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      print("error: " + e.toString());
    }
  }

  Future<bool> addPostComment(CommentModel commentModel) async {
    String userId = await UserViewModel.getUserID();
    commentModel.userId = userId;
    try {
      String result = await CommentRepository.apiAddPostComment(commentModel);
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

  Future<bool> addReplyPostComment(CommentModel commentModel) async {
    String userId = await UserViewModel.getUserID();
    commentModel.userId = userId;
    try {
      String result =
          await CommentRepository.apiAddReplyPostComment(commentModel);
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

  Future<bool> updateComment(CommentModel commentModel) async {
    try {
      String result = await CommentRepository.apiUpdateComment(commentModel);
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

  Future<bool> deleteComment(num id) async {
    try {
      String result = await CommentRepository.apiDeleteComment(id);
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
