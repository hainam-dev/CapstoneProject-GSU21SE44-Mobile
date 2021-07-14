class GuidebookModel{
  String id;
  String title;
  String guidebookContent;
  String imageURL;
  num estimatedFinishTime;
  String createTime;
  num typeId;

  GuidebookModel(
      {this.id,
        this.title,
        this.guidebookContent,
        this.imageURL,
        this.estimatedFinishTime,
        this.createTime,
        this.typeId});

  factory GuidebookModel.fromJson(dynamic json){
    return GuidebookModel(
      id: json['id'],
      title: json['title'],
      guidebookContent: json['guidebookContent'],
      imageURL: json['imageURL'],
      estimatedFinishTime: json['estimateFinishTime'],
      createTime: json['createdTime'],
      typeId: json['typeId'],
    );
  }

}