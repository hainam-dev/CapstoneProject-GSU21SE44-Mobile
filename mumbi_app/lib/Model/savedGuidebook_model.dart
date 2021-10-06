class SavedGuidebookModel {
  num id;
  String momId;
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

  SavedGuidebookModel(
      {this.id,
      this.momId,
      this.guidebookId,
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

  factory SavedGuidebookModel.fromJson(dynamic json) {
    return SavedGuidebookModel(
      id: json['id'],
      guidebookId: json['guidebook']['id'],
      title: json['guidebook']['title'],
      guidebookContent: json['guidebook']['guidebookContent'],
      imageURL: json['guidebook']['imageURL'],
      estimatedFinishTime: json['guidebook']['estimatedFinishTime'],
      createTime: json['guidebook']['createdTime'],
      minSuitableAge: json['guidebook']['minSuitableAge'],
      maxSuitableAge: json['guidebook']['maxSuitableAge'],
      usedFor: json['guidebook']['usedFor'],
      typeId: json['guidebook']['type']['typeId'],
      typeName: json['guidebook']['type']['typeName'],
    );
  }

  Map<String, dynamic> toJson() => {
        'momId': momId,
        'guidebookId': guidebookId,
      };
}
