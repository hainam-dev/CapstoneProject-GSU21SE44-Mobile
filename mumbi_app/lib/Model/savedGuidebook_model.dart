class SavedGuidebookModel {
  num id;
  String momId;
  String guidebookId;
  String title;
  String guidebookContent;
  String imageURL;
  num estimatedFinishTime;
  String createTime;
  num typeId;

  SavedGuidebookModel(
      {this.id,
      this.momId,
      this.guidebookId,
      this.title,
      this.guidebookContent,
      this.imageURL,
      this.estimatedFinishTime,
      this.createTime,
      this.typeId});

  factory SavedGuidebookModel.fromJson(dynamic json) {
    return SavedGuidebookModel(
      id: json['id'],
      guidebookId: json['guidebook']['id'],
      title: json['guidebook']['title'],
      guidebookContent: json['guidebook']['guidebookContent'],
      imageURL: json['guidebook']['imageURL'],
      estimatedFinishTime: json['guidebook']['estimatedFinishTime'],
      createTime: json['guidebook']['createdTime'],
      typeId: json['guidebook']['typeId'],
    );
  }

  Map<String, dynamic> toJson() => {
        'momId': momId,
        'guidebookId': guidebookId,
      };
}
