class ChildModel {
  String childID;
  String fullName;
  String nickname;
  String image;
  String gender;
  String birthday;
  String bloodGroup;
  String rhBloodGroup;
  String fingertips;
  double weight;
  double height;
  double headCircumference;
  double hourSleep;
  double avgMilk;
  String momID;
  String calculatedBornDate;
  double femurLength;
  double fetalHeartRate;
  int pregnancyWeek;
  String pregnancyType;
  int motherMenstrualCycleTime;
  double motherWeight;
  bool isBorn;


  ChildModel({this.childID,
    this.fullName,
    this.nickname,
    this.image,
    this.gender,
    this.birthday,
    this.bloodGroup,
    this.rhBloodGroup,
    this.fingertips,
    this.weight,
    this.height,
    this.headCircumference,
    this.hourSleep,
    this.avgMilk,
    this.momID,
    this.calculatedBornDate,
    this.femurLength,
    this.fetalHeartRate,
    this.pregnancyWeek,
    this.pregnancyType,
    this.motherMenstrualCycleTime,
    this.motherWeight,
    this.isBorn});


  factory ChildModel.fromJson(dynamic json){
    return ChildModel(
      childID : json['id'],
      fullName : json['fullName'],
      nickname : json['nickname'],
      image : json['image'],
      gender : json['gender'],
      birthday : json['birthDay'],
      bloodGroup : json['bloodGroup'],
      rhBloodGroup : json['rhBloodGroup'],
      fingertips : json['fingertips'],
      weight : json['weight'],
      height : json['height'],
      headCircumference : json['headCircumference'],
      hourSleep : json['hourSleep'],
      avgMilk : json['avgMilk'],
      momID : json['momId'],
      calculatedBornDate : json['calculatedBornDate'],
      femurLength : json['femurLength'],
      fetalHeartRate : json['fetalHeartRate'],
      pregnancyWeek : json['pregnancyWeek'],
      pregnancyType : json['pregnancyType'],
      motherMenstrualCycleTime : json['motherMenstrualCycleTime'],
      motherWeight : json['motherWeight'],
      isBorn : json["isBorn"],
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
        'id': childID,
        'fullName': fullName,
        'nickname': image,
        'image': birthday,
        'gender': gender,
        'birthDay': birthday,
        'bloodGroup': bloodGroup,
        'rhBloodGroup': rhBloodGroup,
        'fingertips': fingertips,
        'weight': weight,
        'height': height,
        'headCircumference': headCircumference,
        'hourSleep': hourSleep,
        'avgMilk': avgMilk,
        'momID': momID,
        'calculatedBornDate': calculatedBornDate,
        'femurLength': femurLength,
        'fetalHeartRate': fetalHeartRate,
        'pregnancyWeek': pregnancyWeek,
        'pregnancyType': pregnancyType,
        'motherMenstrualCycleTime': motherMenstrualCycleTime,
        'motherWeight': motherWeight,
        'childrenStatus': isBorn,
      };
}