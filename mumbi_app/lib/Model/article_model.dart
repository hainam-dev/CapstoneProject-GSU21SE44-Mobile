class ArticleModel{
  String id;
  String title;
  String guidebookContent;
  String imageURL;
  int estimateFinishTime;
  String createdBy;
  String createdTime;
  String lastModifiedBy;
  String lastModifiedTime;
  int typeId;
  bool status;

  ArticleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    guidebookContent = json['guidebookContent'];
    imageURL = json['imageURL'];
    estimateFinishTime = json['estimateFinishTime'];
    createdBy = json['createdBy'];
    createdTime = json['createdTime'];
    lastModifiedBy = json['lastModifiedBy'];
    lastModifiedTime = json['lastModifiedTime'];
    typeId = json['typeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['guidebookContent'] = this.guidebookContent;
    data['imageURL'] = this.imageURL;
    data['estimateFinishTime'] = this.estimateFinishTime;
    data['createdBy'] = this.createdBy;
    data['createdTime'] = this.createdTime;
    data['lastModifiedBy'] = this.lastModifiedBy;
    data['lastModifiedTime'] = this.lastModifiedTime;
    data['typeId'] = this.typeId;
    return data;
  }
  ArticleModel({this.id, this.title, this.guidebookContent, this.imageURL, this.estimateFinishTime, this.createdBy, this.createdTime, this.lastModifiedBy, this.lastModifiedTime, this.typeId, this.status});
}