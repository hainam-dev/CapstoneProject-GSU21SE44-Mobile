class ReactionModel {
  num postId;
  num commentId;
  String userId;
  num typeId;

  ReactionModel({this.postId, this.commentId, this.userId, this.typeId});

  factory ReactionModel.fromJson(dynamic json){
    return ReactionModel(
      postId: json['postId'],
      commentId: json['commentId'],
      userId: json['userId'],
      typeId: json['type']['typeId'],
    );
  }

  Map<String, dynamic> toJson() => {
    if(postId != null)
    'postId' : postId,
    if(commentId != null)
    "commentId" : commentId,
    'userId' : userId,
    'typeId': typeId,
  };
}