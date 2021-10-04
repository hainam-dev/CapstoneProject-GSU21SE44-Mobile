class GuidebookTypeModel{
  num id;
  String type;

  GuidebookTypeModel({this.id, this.type});

  factory GuidebookTypeModel.fromJson(dynamic json){
    return GuidebookTypeModel(
      id: json['id'],
      type: json['type'],
    );
  }
}