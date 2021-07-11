class NewsModel{
  String id;
  String title;
  String newsContent;
  String imageURL;
  num estimatedFinishTime;
  String createTime;
  num typeId;


  NewsModel(
      {this.id,
      this.title,
      this.newsContent,
      this.imageURL,
      this.estimatedFinishTime,
      this.createTime,
      this.typeId});

  factory NewsModel.fromJson(dynamic json){
    return NewsModel(
      id: json['id'],
      title: json['title'],
      newsContent: json['newsContent'],
      imageURL: json['imageURL'],
      estimatedFinishTime: json['estimateFinishTime'],
      createTime: json['createdTime'],
      typeId: json['typeId'],
    );
  }

}