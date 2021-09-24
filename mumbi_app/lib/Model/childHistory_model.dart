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
      id: json['id'],
      childId: json['childId'],
      weight: json['weight'],
      height: json['height'],
      headCircumference: json['headCircumference'],
      hourSleep: json['hourSleep'],
      avgMilk: json['avgMilk'],
      weekOlds: json['weekOlds'],
      date: json['date'],
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
class ChildDataModel{
  String month;
  num data;
  ChildDataModel(this.month, this.data);
}