
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

  SavedNewsModel({this.id, this.newsId, this.title, this.newsContent, this.imageURL, this.estimatedFinishTime, this.createTime, this.typeId});

  factory SavedNewsModel.fromJson(dynamic json) {
    return SavedNewsModel(
      id: json['id'],
      newsId: json['newsData']['id'],
      title: json['newsData']['title'],
      newsContent: json['newsData']['newsContent'],
      imageURL: json['newsData']['imageURL'],
      estimatedFinishTime: json['newsData']['estimatedFinishTime'],
      createTime: json['newsData']['createdTime'],
      typeId: json['newsData']['typeId'],
    );
  }

  Map<String, dynamic> toJson() => {
    'momId' : momId,
    'newsId' : newsId,
  };
}
