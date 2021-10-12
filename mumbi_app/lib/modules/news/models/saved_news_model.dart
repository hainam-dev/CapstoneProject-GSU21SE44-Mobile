
class SavedNewsModel {
  num id;
  String momId;
  String newsId;
  String title;
  String newsContent;
  String imageURL;
  num estimatedFinishTime;
  String createTime;
  num typeId;
  String typeName;

  SavedNewsModel({this.id, this.newsId, this.title, this.newsContent, this.imageURL, this.estimatedFinishTime, this.createTime, this.typeId, this.typeName});

  factory SavedNewsModel.fromJson(dynamic json) {
    return SavedNewsModel(
      id: json['id'],
      newsId: json['news']['id'],
      title: json['news']['title'],
      newsContent: json['news']['newsContent'],
      imageURL: json['news']['imageURL'],
      estimatedFinishTime: json['news']['estimatedFinishTime'],
      createTime: json['news']['createdTime'],
      typeId: json['news']['type']['typeId'],
      typeName: json['news']['type']['typeName'],
    );
  }

  Map<String, dynamic> toJson() => {
    'momId' : momId,
    'newsId' : newsId,
  };
}
