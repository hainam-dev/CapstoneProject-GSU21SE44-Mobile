class DiaryModel{
  num id;
  String childId;
  String imageURL;
  String diaryContent;
  String createdBy;
  String createTime;
  String lastModifiedBy;
  String lastModifiedTime;
  bool publicFlag;

  DiaryModel(
      {this.id,
      this.childId,
      this.imageURL,
      this.diaryContent,
      this.createdBy,
      this.createTime,
      this.lastModifiedBy,
      this.lastModifiedTime,
      this.publicFlag});

  factory DiaryModel.fromJson(dynamic json){
    return DiaryModel(
      id : json['id'],
      childId: json['childId'],
      imageURL: json['imageURL'],
      diaryContent: json['diaryContent'],
      createdBy: json['createdBy'],
      createTime: json['createdTime'],
      lastModifiedBy: json['lastModifiedBy'],
      lastModifiedTime: json['lastModifiedTime'],
      publicFlag: json['publicFlag'],
    );
  }

}