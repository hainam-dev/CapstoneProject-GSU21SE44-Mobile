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
      this.approvedTime});

  factory PostModel.fromJson(dynamic json){
    return PostModel(
      id: json['id'],
      fullName: json['userProfile']['fullName'],
      avatar: json['userProfile']['avatar'],
      postContent: json['postContent'],
      imageURL: json['imageURL'],
      createdTime: json['createdTime'],
      lastModifiedTime: json['lastModifiedTime'],
      reviewedBy: json['reviewedBy'],
      approvedTime: json['approvedTime'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id' : id,
    'userId' : userId,
    'postContent' : postContent,
    'imageURL' : imageURL,
  };
}