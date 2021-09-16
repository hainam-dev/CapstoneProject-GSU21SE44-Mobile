class DiaryModel {
  num id;
  String childId;
  String imageURL;
  String diaryContent;
  String createdBy;
  String createTime;
  String lastModifiedTime;

  DiaryModel(
      {this.id,
      this.childId,
      this.imageURL,
      this.diaryContent,
      this.createdBy,
      this.createTime,
      this.lastModifiedTime,
      });

  factory DiaryModel.fromJson(dynamic json) {
    return DiaryModel(
      id: json['id'],
      childId: json['childId'],
      imageURL: json['imageURL'],
      diaryContent: json['diaryContent'],
      createdBy: json['createdBy'],
      createTime: json['createdTime'],
      lastModifiedTime: json['lastModifiedTime'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'childId': childId,
    'imageURL': imageURL,
    'diaryContent': diaryContent,
    'createdBy': createdBy,
    'createdTime': createTime,
    'lastModifiedBy': lastModifiedTime,
  };


}
