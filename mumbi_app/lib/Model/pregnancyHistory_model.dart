class PregnancyHistoryModel{
  num id;
  String childId;
  String date;
  num pregnancyWeek;
  num weight;
  num biparietalDiameter;
  num headCircumference;
  num femurLength;
  num fetalHeartRate;
  num motherWeight;


  PregnancyHistoryModel(
      {this.id,
      this.childId,
      this.date,
      this.pregnancyWeek,
      this.weight,
      this.biparietalDiameter,
      this.headCircumference,
      this.femurLength,
      this.fetalHeartRate,
      this.motherWeight});

  factory PregnancyHistoryModel.fromJson(dynamic json){
    return PregnancyHistoryModel(
      id: json['data']['id'],
      childId: json['data']['childId'],
      date: json['data']['date'],
      pregnancyWeek: json['data']['pregnancyWeek'],
      weight: json['data']['weight'],
      biparietalDiameter: json['data']['biparietalDiameter'],
      headCircumference: json['data']['headCircumference'],
      femurLength: json['data']['femurLength'],
      fetalHeartRate: json['data']['fetalHeartRate'],
      motherWeight: json['data']['motherWeight'],
    );
  }

  Map<String,dynamic> toJson() => {
    'childId' : childId,
    'pregnancyWeek' : pregnancyWeek,
    'weight' : weight,
    'biparietalDiameter' : biparietalDiameter,
    'headCircumference' : headCircumference,
    'femurLength' : femurLength,
    'fetalHeartRate' : fetalHeartRate,
    'motherWeight' : motherWeight,
  };
}