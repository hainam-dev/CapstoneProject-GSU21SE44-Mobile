class TeethModel{
  String icon;
  String iconChoose;
  int position;
  bool flag;
  double width, height,top, left;
  String name;
  String growTime;

  String toothId;
  String childId;
  String grownDate;
  String note;
  String imageURL;
  bool grownFlag;

  TeethModel({this.position, this.name, this.growTime});

  factory TeethModel.fromJson(dynamic json) {
    return TeethModel( position : json['data']['position'],
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

class TeethInfo {
  String toothId;
  String childId;
  String grownDate;
  String note;
  String imageURL;
  bool grownFlag;

  TeethInfo({this.toothId, this.childId, this.grownDate, this.note, this.imageURL, this.grownFlag});

  TeethInfo.fromJson(Map<String, dynamic> json) {
    toothId = json['toothId'];
    childId = json['childId'];
    grownDate = json['grownDate'];
    note = json['note'];
    imageURL = json['imageURL'];
    grownFlag = json['grownFlag'];
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