class DadModel{
  String id;
  String fullName;
  String imageURL;
  String birthday;
  String phoneNumber;
  String bloodGroup;
  String rhBloodGroup;
  String momID;


  DadModel(
      {this.id,
      this.fullName,
      this.imageURL,
      this.birthday,
      this.phoneNumber,
      this.bloodGroup,
      this.rhBloodGroup,
      this.momID});

  DadModel.fromJson(Map<String,dynamic> json):
        id = json['data']['id'],
        fullName = json['data']['fullName'],
        imageURL = json['data']['imageURL'],
        birthday = json['data']['birthday'],
        phoneNumber = json['data']['phonenumber'],
        bloodGroup = json['data']['bloodGroup'],
        rhBloodGroup = json['data']['rhBloodGroup'],
        momID = json['data']['momId'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'fullName' :fullName,
    'imageURL' : imageURL,
    'birthday' : birthday,
    'phonenumber' : phoneNumber,
    'bloodGroup' : bloodGroup,
    'rhBloodGroup' : rhBloodGroup,
    'momId' : momID,
  };
}
