class ActionModel {
  int id;
  int actionId;
  String name;
  String type;
  int month;
  bool checkedFlag;
  String childID;

  ActionModel({this.id, this.name, this.type, this.month, this.checkedFlag, this.childID});

  factory ActionModel.fromJson(dynamic json) {
    return ActionModel(
        id : json['id'],
        name : json['name'],
        type : json['type'],
        month : json['month'],
        checkedFlag : json['checkedFlag'],
    );
  }

  factory ActionModel.fromJsonAll(dynamic json) {
    return ActionModel(
        id : json['actionId'],
        checkedFlag : json['checkedFlag'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['month'] = this.month;
    return data;
  }

  Map<String, dynamic> toJsonActionChild() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['childId'] = this.childID;
    data['actionId'] = this.id;
    data['checkedFlag'] = this.checkedFlag;
    return data;
  }
}