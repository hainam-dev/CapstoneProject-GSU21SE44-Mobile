class GuidebookModel{
  String guidebookId;
  String title;
  String guidebookContent;
  String imageURL;
  num estimatedFinishTime;
  String createTime;
  num minSuitableAge;
  num maxSuitableAge;
  bool usedFor;
  num typeId;
  String typeName;


  GuidebookModel(
      {this.guidebookId,
      this.title,
      this.guidebookContent,
      this.imageURL,
      this.estimatedFinishTime,
      this.createTime,
      this.minSuitableAge,
      this.maxSuitableAge,
      this.usedFor,
      this.typeId,
      this.typeName});

  factory GuidebookModel.fromJson(dynamic json){
    return GuidebookModel(
      guidebookId: json['id'],
      title: json['title'],
      guidebookContent: json['guidebookContent'],
      imageURL: json['imageURL'],
      estimatedFinishTime: json['estimatedFinishTime'],
      createTime: json['createdTime'],
      minSuitableAge: json['minSuitableAge'],
      maxSuitableAge: json['maxSuitableAge'],
      usedFor: json['usedFor'],
      typeId: json['type']['typeId'],
      typeName: json['type']['typeName'],
    );
  }

}