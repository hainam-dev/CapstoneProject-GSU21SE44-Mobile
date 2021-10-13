class StandardIndexModel {
  num id;
  num age;
  String type;
  int gender;
  String unit;
  num N3SD;
  num N2SD;
  num N1SD;
  num mean;
  num P1SD;
  num P2SD;
  num P3SD;
  bool status;


  StandardIndexModel(
      {this.id,
      this.age,
      this.type,
      this.gender,
      this.unit,
      this.N3SD,
      this.N2SD,
      this.N1SD,
      this.mean,
      this.P1SD,
      this.P2SD,
      this.P3SD,
      this.status});

  factory StandardIndexModel.fromJson(dynamic json) {
    return StandardIndexModel(
      id : json['id'],
      age : json['age'],
      type : json['type'],
      gender: json['gender'],
      unit: json['unit'],
      N3SD : json['_3sd'],
      N2SD : json['_2sd'],
      N1SD : json['_1sd'],
      mean : json['mean'],
      P1SD : json['_1sd'],
      P2SD : json['_1sd'],
      P3SD : json['_1sd'],
      status: json['status'],
    );
  }
}
