class ToothInfoModel{
  String icon;
  String iconChoose;
  int position;
  bool flag;
  double width, height,top, left;
  String name;
  String growTime;

  ToothInfoModel({this.position, this.name, this.growTime});

  factory ToothInfoModel.fromJson(dynamic json) {
    return ToothInfoModel( position : json['data']['position'],
      name : json['data']['name'],
      growTime : json['data']['growTime'],);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['position'] = this.position;
    data['name'] = this.name;
    data['growTime'] = this.growTime;
    return data;
  }
}

class ToothModel {
  String toothId;
  String childId;
  DateTime grownDate;
  String note;
  String imageURL;
  bool grownFlag;

  ToothModel({this.toothId, this.childId, this.grownDate, this.note, this.imageURL, this.grownFlag});

  factory ToothModel.fromJson(dynamic json) {
    return ToothModel(
        toothId : json['data']['toothId'],
        childId : json['data']['childId'],
        grownDate : DateTime.parse(json['data']['grownDate']),
    note : json['data']['note'],
    imageURL : json['data']['imageURL'],
    grownFlag : json['data']['grownFlag'],

    );

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['toothId'] = this.toothId;
    data['childId'] = this.childId;
    data['grownDate'] = this.grownDate;
    data['note'] = this.note;
    data['imageURL'] = this.imageURL;
    data['grownFlag'] = this.grownFlag;
    return data;
  }
}