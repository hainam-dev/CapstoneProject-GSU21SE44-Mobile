class ChildModel {
  String id;
  String fullName;
  String nickname;
  String imageURL;
  num gender;
  String estimatedBornDate;
  String birthday;
  String bloodGroup;
  String rhBloodGroup;
  num fingertips;
  num headVortex;
  String momID;
  bool bornFlag;

  ChildModel(
      {this.id,
      this.fullName,
      this.nickname,
      this.imageURL,
      this.gender,
      this.estimatedBornDate,
      this.birthday,
      this.bloodGroup,
      this.rhBloodGroup,
      this.fingertips,
      this.headVortex,
      this.momID,
      this.bornFlag,});

  factory ChildModel.fromJson(dynamic json){
    return ChildModel(
      id : json['id'],
      fullName : json['fullName'],
      nickname : json['nickname'],
      imageURL : json['imageURL'],
      gender : json['gender'],
      estimatedBornDate : json['estimatedBornDate'],
      birthday : json['birthday'],
      bloodGroup : json['bloodGroup'],
      rhBloodGroup : json['rhBloodGroup'],
      fingertips : json['fingertips'],
      headVortex: json['headVortex'],
      momID : json['momId'],
      bornFlag : json['bornFlag'],);
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'fullName': fullName,
        'nickname': nickname,
        'imageURL': imageURL,
        'gender': gender,
        'estimatedBornDate': estimatedBornDate,
        'birthday': birthday,
        'bloodGroup': bloodGroup,
        'rhBloodGroup': rhBloodGroup,
        'fingertips': fingertips,
        'headVortex' : headVortex,
        'momID': momID,
        'childrenStatus': bornFlag == true ? 2 : 1,
      };
}