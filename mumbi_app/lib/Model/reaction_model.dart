class ReactionModel {
  num id;
  num postId;
  num commentId;
  String userId;
  num typeId;

  ReactionModel({this.id,this.postId, this.commentId, this.userId, this.typeId});

  factory ReactionModel.fromJson(dynamic json){
    return ReactionModel(
      id: json['id'],
      postId: json['postId'],
      commentId: json['commentId'],
      userId: json['userId'],
      typeId: json['type']['typeId'],
    );
  }

  Map<String, dynamic> toJson() => {
    'postId' : postId,
    'commentId' : commentId,
    'userId' : userId,
    'typeId': typeId,
  };
}
