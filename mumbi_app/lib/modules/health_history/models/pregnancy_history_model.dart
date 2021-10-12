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
      id: json['id'],
      childId: json['childId'],
      date: json['date'],
      pregnancyWeek: json['pregnancyWeek'],
      weight: json['weight'],
      biparietalDiameter: json['biparietalDiameter'],
      headCircumference: json['headCircumference'],
      femurLength: json['femurLength'],
      fetalHeartRate: json['fetalHeartRate'],
      motherWeight: json['motherWeight'],
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