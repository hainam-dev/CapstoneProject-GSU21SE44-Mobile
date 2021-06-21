import 'dart:ffi';

class ChildModel{
  String childID;
  String fullName;
  String nickname;
  String image;
  int gender;
  DateTime birthday;
  String bloodGroup;
  String rhBloodGroup;
  String fingertips;
  Float weight;
  Float height;
  Float headCircumference;
  Float hourSleep;
  Float avgMilk;
  String momID;
  DateTime calculatedBornDate;
  Float femurLength;
  Float fetalHeartRate;
  int pregnancyWeek;
  String pregnancyType;
  int motherMenstrualCycleTime;
  Float motherWeight;

  ChildModel(
      this.childID,
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
      this.motherWeight);

  ChildModel.fromJson(Map<String,dynamic> json):
        childID = json['id'],
        fullName = json['fullName'],
        nickname = json['nickname'],
        image = json['image'],
        gender = json['gender'],
        birthday = json['birthDay'],
        bloodGroup = json['bloodGroup'],
        rhBloodGroup = json['rhBloodGroup'],
        fingertips = json['fingertips'],
        weight = json['weight'],
        height = json['height'],
        headCircumference = json['headCircumference'],
        hourSleep = json['hourSleep'],
        avgMilk = json['avgMilk'],
        momID = json['momId'],
        calculatedBornDate = json['calculatedBornDate'],
        femurLength = json['femurLength'],
        fetalHeartRate = json['fetalHeartRate'],
        pregnancyWeek = json['pregnancyWeek'],
        pregnancyType = json['pregnancyType'],
        motherMenstrualCycleTime = json['motherMenstrualCycleTime'],
        motherWeight = json['motherWeight'];

  Map<String, dynamic> toJson() => {
    'id' : childID,
    'fullName' :fullName,
    'nickname' : image,
    'image' : birthday,
    'gender' : gender,
    'birthDay' : birthday,
    'bloodGroup' : bloodGroup,
    'rhBloodGroup' : rhBloodGroup,
    'fingertips' : fingertips,
    'weight' : weight,
    'height' : height,
    'headCircumference' : headCircumference,
    'hourSleep' : hourSleep,
    'avgMilk' : avgMilk,
    'momId' : momID,
    'calculatedBornDate' : calculatedBornDate,
    'femurLength' : femurLength,
    'fetalHeartRate' : fetalHeartRate,
    'pregnancyWeek' : pregnancyWeek,
    'pregnancyType' : pregnancyType,
    'motherMenstrualCycleTime' : motherMenstrualCycleTime,
    'motherWeight' : motherWeight,
  };
}