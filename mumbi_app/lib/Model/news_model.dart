class NewsModel{
  String newsId;
  String title;
  String newsContent;
  String imageURL;
  num estimatedFinishTime;
  String createTime;
  num typeId;


  NewsModel(
      {this.newsId,
      this.title,
      this.newsContent,
      this.imageURL,
      this.estimatedFinishTime,
      this.createTime,
      this.typeId});

  factory NewsModel.fromJson(dynamic json){
    return NewsModel(
      newsId: json['id'],
      title: json['title'],
      newsContent: json['newsContent'],
      imageURL: json['imageURL'],
      estimatedFinishTime: json['estimatedFinishTime'],
      createTime: json['createdTime'],
      typeId: json['typeId'],
    );
  }

}