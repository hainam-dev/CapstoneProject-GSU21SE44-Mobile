class CommentModel{
  num id;
  num postId;
  String userId;
  String fullName;
  String avatar;
  String commentContent;
  String imageURL;
  String createdTime;
  String lastModifiedTime;
  num replyCommentId;
  num totalReaction;
  num totalReply;
  List replyList;
  num idReaction;

  CommentModel(
      {this.id,
      this.postId,
      this.userId,
      this.fullName,
      this.avatar,
      this.commentContent,
      this.imageURL,
      this.createdTime,
      this.lastModifiedTime,
      this.replyCommentId});

  factory CommentModel.fromJson(dynamic json){
    return CommentModel(
      id: json['id'],
      postId: json['postId'],
      userId: json['userId'],
      fullName: json['userProfile']['fullName'],
      avatar: json['userProfile']['avatar'],
      commentContent: json['commentContent'],
      imageURL: json['imageURL'],
      createdTime: json['createdTime'],
      lastModifiedTime: json['lastModifiedTime'],
      replyCommentId: json['replyCommentId'],
    );
  }

  Map<String, dynamic> toJson() => {
    'postId' : postId,
    'userId' : userId,
    'userProfile': {
      'fullName' : fullName,
      'avatar' : avatar,
    },
    'commentContent' : commentContent,
    'imageURL' : imageURL,
    'replyCommentId' : replyCommentId,
  };

}