class ActivityModel{
  num id;
  String activityName;
  String mediaFileURL;
  num suitableAge;

  ActivityModel(
      {this.id, this.activityName, this.mediaFileURL, this.suitableAge});

  factory ActivityModel.fromJson(dynamic json){
    return ActivityModel(
      id: json['id'],
      activityName: json['activityName'],
      mediaFileURL: json['mediaFileURL'],
      suitableAge: json['suitableAge'],
    );
  }
}