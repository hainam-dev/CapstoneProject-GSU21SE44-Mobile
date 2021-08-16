class ChildHistoryModel{
  num id;
  String childId;
  num weight;
  num height;
  num headCircumference;
  num hourSleep;
  num avgMilk;
  num weekOlds;
  String date;

  ChildHistoryModel(
      {this.id,
      this.childId,
      this.weight,
      this.height,
      this.headCircumference,
      this.hourSleep,
      this.avgMilk,
      this.weekOlds,
      this.date});

  factory ChildHistoryModel.fromJson(dynamic json){
    return ChildHistoryModel(
      id: json['data']['id'],
      childId: json['data']['childId'],
      weight: json['data']['weight'],
      height: json['data']['height'],
      headCircumference: json['data']['headCircumference'],
      hourSleep: json['data']['hourSleep'],
      avgMilk: json['data']['avgMilk'],
      weekOlds: json['data']['weekOlds'],
      date: json['data']['date'],
    );
  }

  Map<String,dynamic> toJson() => {
    'childId' : childId,
    'weight' : weight,
    'height' : height,
    'headCircumference' : headCircumference,
    'hourSleep' : hourSleep,
    'avgMilk' : avgMilk,
    'weekOlds' : weekOlds,
  };
}