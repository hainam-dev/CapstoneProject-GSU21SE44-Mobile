import 'dart:ffi';

class MomModel{
  String accountID;
  String fullName;
  String image;
  String birthday;
  String phoneNumber;
  String bloodGroup;
  String rhBloodGroup;
  int weight;
  int height;

  MomModel(
      this.accountID,
      this.fullName,
      this.image,
      this.birthday,
      this.phoneNumber,
      this.bloodGroup,
      this.rhBloodGroup,
      this.weight,
      this.height);

  MomModel.fromJson(Map<String,dynamic> json):
      accountID = json['data']['accountId'],
      fullName = json['data']['fullName'],
      image = json['data']['image'],
      birthday = json['data']['birthday'],
      phoneNumber = json['data']['phonenumber'],
      bloodGroup = json['data']['bloodGroup'],
      rhBloodGroup = json['data']['rhBloodGroup'],
      weight = json['data']['weight'],
      height = json['data']['height'];

  Map<String, dynamic> toJson() => {
    'accountId' : accountID,
    'fullName' :fullName,
    'image' : image,
    'birthday' : birthday,
    'phonenumber' : phoneNumber,
    'bloodGroup' : bloodGroup,
    'rhBloodGroup' : rhBloodGroup,
    'weight' : weight,
    'height' : height,
  };

}