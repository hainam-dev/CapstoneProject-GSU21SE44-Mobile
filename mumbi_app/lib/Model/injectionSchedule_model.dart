import 'package:mumbi_app/Utils/datetime_convert.dart';

class InjectionScheduleModel {
  num injectionScheduleId;
  String momId;
  String childId;
  num injectedPersonId;
  String vaccineName;
  String antigen;
  String injectionDateTime;
  DateTime date;
  num orderOfInjection;
  String vaccineBatch;
  String vaccinationFacility;
  num status;

  InjectionScheduleModel(
      {this.injectionScheduleId,
      this.momId,
      this.childId,
      this.injectedPersonId,
      this.vaccineName,
      this.antigen,
      this.injectionDateTime,
        this.date,
      this.orderOfInjection,
      this.vaccineBatch,
      this.vaccinationFacility,
      this.status});

  factory InjectionScheduleModel.fromJson(dynamic json) {
    return InjectionScheduleModel(
      injectionScheduleId: json['injectionScheduleId'],
      momId: json['momId'],
      childId: json['childId'],
      injectedPersonId: json['injectedPersonId'],
      vaccineName: json['vaccineName'],
      antigen: json['antigen'],
      injectionDateTime: json['injectionDate'],
      date: DateTimeConvert.convertStringToDatetimeDMY(json['injectionDate'].split(" ")[1]),
      orderOfInjection: json['orderOfInjection'],
      vaccineBatch: json['vaccineBatch'],
      vaccinationFacility: json['vaccinationFacility'],
      status: json['status'],
    );
  }
}
