class ChildModel {
  String id;
  String fullName;
  String nickname;
  String imageURL;
  String gender;
  String estimatedBornDate;
  String birthday;
  String bloodGroup;
  String rhBloodGroup;
  num fingertips;
  num headVortex;
  String momID;
  bool bornFlag;
  num weight;
  num height;
  num headCircumference;
  num hourSleep;
  num avgMilk;
  num femurLength;
  num fetalHeartRate;
  num pregnancyWeek;
  num motherWeight;


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
      this.bornFlag,
      this.weight,
      this.height,
      this.headCircumference,
      this.hourSleep,
      this.avgMilk,
      this.femurLength,
      this.fetalHeartRate,
      this.pregnancyWeek,
      this.motherWeight});

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
      bornFlag : json['bornFlag'],
      weight : json['weight'],
      height : json['height'],
      headCircumference : json['headCircumference'],
      hourSleep : json['hourSleep'],
      avgMilk : json['avgMilk'],
      femurLength : json['femurLength'],
      fetalHeartRate : json['fetalHeartRate'],
      pregnancyWeek : json['pregnancyWeek'],
      motherWeight : json['motherWeight'],
    );
  }

  /*ChildModel.fromJson(Map<String,dynamic> json):
        childID = json['data']['id'],
        fullName = json['data']['fullName'],
        nickname = json['data']['nickname'],
        image = json['data']['image'],
        gender = json['data']['gender'],
        birthday = json['data']['birthDay'],
        bloodGroup = json['data']['bloodGroup'],
        rhBloodGroup = json['data']['rhBloodGroup'],
        fingertips = json['data']['fingertips'],
        weight = json['data']['weight'],
        height = json['data']['height'],
        headCircumference = json['data']['headCircumference'],
        hourSleep = json['data']['hourSleep'],
        avgMilk = json['data']['avgMilk'],
        momID = json['data']['momId'],
        calculatedBornDate = json['data']['calculatedBornDate'],
        femurLength = json['data']['femurLength'],
        fetalHeartRate = json['data']['fetalHeartRate'],
        pregnancyWeek = json['data']['pregnancyWeek'],
        pregnancyType = json['data']['pregnancyType'],
        motherMenstrualCycleTime = json['data']['motherMenstrualCycleTime'],
        motherWeight = json['data']['motherWeight'],
        isBorn =  json['data']["isBorn"];*/

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
        'weight': weight,
        'height': height,
        'headCircumference': headCircumference,
        'hourSleep': hourSleep,
        'avgMilk': avgMilk,
        'femurLength': femurLength,
        'fetalHeartRate': fetalHeartRate,
        'pregnancyWeek': pregnancyWeek,
        'motherWeight': motherWeight,
        'childrenStatus': bornFlag == true ? 2 : 1,
      };
}