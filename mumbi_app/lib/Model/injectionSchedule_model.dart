class InjectionScheduleModel {
  num injectionScheduleId;
  String momId;
  String childId;
  num injectedPersonId;
  String vaccineName;
  String antigen;
  String injectionDate;
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
      this.injectionDate,
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
      injectionDate: json['injectionDate'],
      orderOfInjection: json['orderOfInjection'],
      vaccineBatch: json['vaccineBatch'],
      vaccinationFacility: json['vaccinationFacility'],
      status: json['status'],
    );
  }
}
