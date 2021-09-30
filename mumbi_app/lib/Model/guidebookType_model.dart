class GuidebookTypeModel{
  num id;
  String type;
  num postQuantity;

  GuidebookTypeModel({this.id, this.type});

  factory GuidebookTypeModel.fromJson(dynamic json){
    return GuidebookTypeModel(
      id: json['id'],
      type: json['type'],
    );
  }
}