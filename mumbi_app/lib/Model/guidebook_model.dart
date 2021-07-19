class GuidebookModel{
  String guidebookId;
  String title;
  String guidebookContent;
  String imageURL;
  num estimatedFinishTime;
  String createTime;
  num typeId;

  GuidebookModel(
      {this.guidebookId,
        this.title,
        this.guidebookContent,
        this.imageURL,
        this.estimatedFinishTime,
        this.createTime,
        this.typeId});

  factory GuidebookModel.fromJson(dynamic json){
    return GuidebookModel(
      guidebookId: json['id'],
      title: json['title'],
      guidebookContent: json['guidebookContent'],
      imageURL: json['imageURL'],
      estimatedFinishTime: json['estimatedFinishTime'],
      createTime: json['createdTime'],
      typeId: json['typeId'],
    );
  }

}