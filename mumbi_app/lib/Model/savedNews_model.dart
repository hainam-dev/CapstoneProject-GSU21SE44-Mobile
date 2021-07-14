class SavedNewsModel {
  num id;
  String momId;
  String newsId;

  SavedNewsModel({this.id, this.momId, this.newsId});

  factory SavedNewsModel.fromJson(dynamic json) {
    return SavedNewsModel(
      id: json['id'],
      momId: json['momId'],
      newsId: json['newsId'],
    );
  }
}
