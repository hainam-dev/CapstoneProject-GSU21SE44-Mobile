class StandardIndexModel {
  int id;
  int month;
  String type;
  int gender;
  String unit;
  double minValue;
  double maxValue;

  StandardIndexModel(
      {this.id,
        this.month,
        this.type,
        this.gender,
        this.unit,
        this.minValue,
        this.maxValue});

  factory StandardIndexModel.fromJson(dynamic json) {
    return StandardIndexModel(
        id : json['id'],
        month : json['month'],
        type : json['type'],
        gender : json['gender'],
        unit : json['unit'],
        minValue: json['minValue'].toDouble(),
        maxValue : json['maxValue'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['month'] = this.month;
    data['type'] = this.type;
    data['gender'] = this.gender;
    data['unit'] = this.unit;
    data['minValue'] = this.minValue;
    data['maxValue'] = this.maxValue;
    return data;
  }
}

class HeadModel extends StandardIndexModel{
  double minValue;
  double maxValue;
  HeadModel({this.maxValue,this.minValue});
}
class WeightModel {
  double minValue;
  double maxValue;
  WeightModel({this.maxValue,this.minValue});
}
// class HeadModel {
//   double minValue;
//   double maxValue;
//   HeadModel({this.maxValue,this.minValue});
// }