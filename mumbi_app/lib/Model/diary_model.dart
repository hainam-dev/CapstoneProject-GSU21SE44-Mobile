class DiaryModel {
  num id;
  String childId;
  String imageURL;
  String diaryContent;
  String avatarUser;
  String createdByName;
  String createdByID;
  String createTime;
  String lastModifiedBy;
  String lastModifiedTime;
  String publicDate;
  bool publicFlag;
  bool approvedFlag;

  DiaryModel(
      {this.id,
      this.childId,
      this.imageURL,
      this.diaryContent,
      this.avatarUser,
      this.createdByName,
      this.createdByID,
      this.createTime,
      this.lastModifiedBy,
      this.lastModifiedTime,
      this.publicDate,
      this.publicFlag,
      this.approvedFlag});

  factory DiaryModel.fromJson(dynamic json) {
    return DiaryModel(
      id: json['id'],
      childId: json['childId'],
      imageURL: json['imageURL'],
      diaryContent: json['diaryContent'],
      avatarUser: json['imageURLCreateBy'],
      createdByName: json['nameCreatedBy'],
      createdByID: json['createdBy'],
      createTime: json['createdTime'],
      lastModifiedBy: json['lastModifiedBy'],
      lastModifiedTime: json['lastModifiedTime'],
      publicDate: json['publicDate'],
      publicFlag: json['publicFlag'],
      approvedFlag: json['approvedFlag'],
    );
  }

  Map<String, dynamic> toJson() => {
    'childId': childId,
    'imageURL': imageURL,
    'diaryContent': diaryContent,
    'createdBy': createdByID,
    'lastModifiedBy': lastModifiedBy,
    'publicFlag': publicFlag,
  };
}
