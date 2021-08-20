import 'dart:convert';

import 'package:mumbi_app/Model/injectionSchedule_model.dart';
import 'package:mumbi_app/Model/news_model.dart';
import 'package:mumbi_app/Repository/vaccination_respository.dart';
import 'package:scoped_model/scoped_model.dart';

class InjectionScheduleViewModel extends Model{

  static InjectionScheduleViewModel _instance;

  static InjectionScheduleViewModel getInstance() {
    if (_instance == null) {
      _instance = InjectionScheduleViewModel();
    }
    return _instance;
  }

  static void destroyInstance() {
    _instance = null;
  }

  List<dynamic> injectionScheduleList;
  List<InjectionScheduleModel> injectionScheduleListModel;

  void getInjectionSchedule(String childId) async{
    try{
      String data = await VaccinationRespository.apiGetInjectionSchedule(childId);
      Map<String, dynamic> jsonList = json.decode(data);
      injectionScheduleList = jsonList['data'];
      if(injectionScheduleList != null){
        injectionScheduleListModel = injectionScheduleList.map((e) => InjectionScheduleModel.fromJson(e)).toList();
        injectionScheduleListModel.sort((a,b) => b.injectionDate.compareTo(a.injectionDate));
      }else{
        injectionScheduleListModel = null;
      }
      notifyListeners();
    }catch(e){
      print("error: " + e.toString());
    }
  }


}