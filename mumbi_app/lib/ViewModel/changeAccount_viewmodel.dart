import 'package:mumbi_app/ViewModel/childHistory_viewmodel.dart';
import 'package:mumbi_app/ViewModel/diary_viewmodel.dart';
import 'package:mumbi_app/ViewModel/injectionSchedule_viewmodel.dart';
import 'package:mumbi_app/ViewModel/pregnancyViewModel.dart';
import 'package:mumbi_app/ViewModel/tooth_viewmodel.dart';

class ChangeAccountViewModel{

  void destroyInstance(){
    DiaryViewModel.destroyInstance();
    InjectionScheduleViewModel.destroyInstance();
    ToothViewModel.destroyInstance();
    ChildHistoryViewModel.destroyInstance();
    PregnancyHistoryViewModel.destroyInstance();
  }
}