import 'package:mumbi_app/Model/injectionSchedule_model.dart';
import 'package:mumbi_app/ViewModel/diary_viewmodel.dart';
import 'package:mumbi_app/ViewModel/injectionSchedule_viewmodel.dart';

class ChangeAccountViewModel{

  void destroyInstance(){
    DiaryViewModel.destroyInstance();
    InjectionScheduleViewModel.destroyInstance();
  }
}