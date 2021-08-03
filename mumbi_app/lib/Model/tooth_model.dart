import 'dart:convert' show json;

import 'package:intl/intl.dart';
class ToothInfoModel{
  String id;
  String icon;
  String iconChoose;
  int position;
  bool flag;
  double width, height,top, left;
  String name;
  String growTime;
  int number;

  ToothInfoModel({this.id,this.position,this.number, this.name, this.growTime});

  factory ToothInfoModel.fromJson(dynamic json) {
    return ToothInfoModel(
      id: json['data']['id'],
      position : json['data']['position'],
      name : json['data']['name'],
      growTime : json['data']['growTime'],
      number : json['data']['number'],);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['position'] = this.position;
    data['id'] = this.id;
    data['name'] = this.name;
    data['growTime'] = this.growTime;
    data['number'] = this.number;
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
  String toothName;
  int position;

  ToothModel({this.toothId, this.childId, this.grownDate, this.note, this.imageURL, this.grownFlag, this.toothName, this.position});

  factory ToothModel.fromJson(dynamic json) {
    return ToothModel(
        toothId : json['data']['toothId'],
        childId : json['data']['childId'],
        grownDate : DateTime.tryParse(json['data']['grownDate']),
        note : json['data']['note'],
        imageURL : json['data']['imageURL'],
        grownFlag : json['data']['grownFlag'],
        position : json['data']['position'],
    );
  }

  factory ToothModel.fromJsonModel(dynamic json) {
    return ToothModel(
      toothId : json['toothId'],
      childId : json['childId'],
      grownDate : DateTime.tryParse(json['grownDate']),
      note : json['note'],
      imageURL : json['imageURL'],
      grownFlag : json['grownFlag'],
      toothName : json['toothName'],
      position : json['position'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['toothId'] = this.toothId;
    data['childId'] = this.childId;
    String formattedDate = DateFormat('yyyy-MM-dd').format(this.grownDate);
    data['grownDate'] = formattedDate;
    data['note'] = this.note;
    data['imageURL'] = this.imageURL;
    data['grownFlag'] = this.grownFlag;
    return data;
  }
}