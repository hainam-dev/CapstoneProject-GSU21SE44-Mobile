class MomModel{
  String id;
  String fullName;
  String imageURL;
  String birthday;
  String phoneNumber;
  String bloodGroup;
  String rhBloodGroup;
  num weight;
  num height;
  String dadID;

  MomModel(
      {this.id,
      this.fullName,
      this.imageURL,
      this.birthday,
      this.phoneNumber,
      this.bloodGroup,
      this.rhBloodGroup,
      this.weight,
      this.height,
      this.dadID});

  factory MomModel.fromJson(dynamic json){
    return MomModel(
      id : json['data']['id'],
      fullName: json['data']['fullName'],
      imageURL: json['data']['imageURL'],
      birthday : json['data']['birthday'],
      phoneNumber : json['data']['phonenumber'],
      bloodGroup : json['data']['bloodGroup'],
      rhBloodGroup : json['data']['rhBloodGroup'],
      weight : json['data']['weight'],
      height : json['data']['height'],
      dadID : json['data']['dad_Id'],
    );
  }


  Map<String, dynamic> toJson() => {
    'id' : id,
    'fullName' :fullName,
    'imageUrl' : imageURL,
    'birthDay' : birthday,
    'phonenumber' : phoneNumber,
    'bloodGroup' : bloodGroup,
    'rhBloodGroup' : rhBloodGroup,
    'weight' : weight,
    'height' : height,
  };

}