class PostModel{
  num id;
  String userId;
  String fullName;
  String avatar;
  String postContent;
  String imageURL;
  String createdTime;
  String lastModifiedTime;
  String reviewedBy;
  String approvedTime;
  num totalReaction;
  num totalComment;
  num idReaction;

  PostModel(
      {this.id,
        this.userId,
      this.fullName,
      this.avatar,
      this.postContent,
      this.imageURL,
      this.createdTime,
      this.lastModifiedTime,
      this.reviewedBy,
      this.approvedTime,
      this.totalReaction,
      this.totalComment});

  factory PostModel.fromJson(dynamic json){
    return PostModel(
      id: json['id'],
      userId: json['userId'],
      fullName: json['userProfile']['fullName'],
      avatar: json['userProfile']['avatar'],
      postContent: json['postContent'],
      imageURL: json['imageURL'],
      createdTime: json['createdTime'],
      lastModifiedTime: json['lastModifiedTime'],
      reviewedBy: json['reviewedBy'],
      approvedTime: json['approvedTime'],
      totalReaction: json['countReactPost'],
      totalComment: json['countCommentPost'],
    );
  }

  Map<String, dynamic> toJson() => {
    'userId' : userId,
    'postContent' : postContent,
    'imageURL' : imageURL,
  };
}