class StandardIndex {
  int id;
  int month;
  String type;
  int gender;
  String unit;
  double minValue;
  int maxValue;

  StandardIndex(
      {this.id,
        this.month,
        this.type,
        this.gender,
        this.unit,
        this.minValue,
        this.maxValue});

  factory StandardIndex.fromJson(Map<String, dynamic> json) {
    return StandardIndex(
        id : json['data']['id'],
        month : json['data']['month'],
        type : json['data']['type'],
        gender : json['data']['gender'],
        unit : json['data']['unit'],
        minValue: json['data']['minValue'],
            maxValue : json['data']['maxValue'],
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