class ActionModel {
  int id;
  String name;
  String type;
  int month;

  ActionModel({this.id, this.name, this.type, this.month});

  factory ActionModel.fromJson(dynamic json) {
    return ActionModel(
        id : json['data']['id'],
        name : json['data']['name'],
        type : json['data']['type'],
        month : json['data']['month'],
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
}