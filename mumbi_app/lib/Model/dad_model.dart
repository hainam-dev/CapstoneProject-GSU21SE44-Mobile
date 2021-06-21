class DadModel{
  String Id;
  String fullName;
  String image;
  DateTime birthday;
  String phoneNumber;
  String bloodGroup;
  String rhBloodGroup;
  String momID;

  DadModel(this.fullName, this.image, this.birthday, this.phoneNumber,
      this.bloodGroup, this.rhBloodGroup);

  DadModel.fromJson(Map<String,dynamic> json):
        Id = json['data']['id'],
        fullName = json['data']['fullName'],
        image = json['data']['image'],
        birthday = json['data']['birthday'],
        phoneNumber = json['data']['phonenumber'],
        bloodGroup = json['data']['bloodGroup'],
        rhBloodGroup = json['data']['rhBloodGroup'],
        momID = json['data']['momId'];

  Map<String, dynamic> toJson() => {
    'id' : Id,
    'fullName' :fullName,
    'image' : image,
    'birthday' : birthday,
    'phonenumber' : phoneNumber,
    'bloodGroup' : bloodGroup,
    'rhBloodGroup' : rhBloodGroup,
    'momId' : momID,
  };
}
