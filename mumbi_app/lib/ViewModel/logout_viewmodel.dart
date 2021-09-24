import 'package:mumbi_app/Global/CurrentMember.dart';
import 'package:mumbi_app/View/injectionSchedule.dart';
import 'package:mumbi_app/ViewModel/action_viewmodel.dart';
import 'package:mumbi_app/ViewModel/activity_viewmodel.dart';
import 'package:mumbi_app/ViewModel/childHistory_viewmodel.dart';
import 'package:mumbi_app/ViewModel/child_viewmodel.dart';
import 'package:mumbi_app/ViewModel/dad_viewmodel.dart';
import 'package:mumbi_app/ViewModel/diary_viewmodel.dart';
import 'package:mumbi_app/ViewModel/injectionSchedule_viewmodel.dart';
import 'package:mumbi_app/ViewModel/mom_viewmodel.dart';
import 'package:mumbi_app/ViewModel/pregnancyViewModel.dart';
import 'package:mumbi_app/ViewModel/savedGuidebook_viewmodel.dart';
import 'package:mumbi_app/ViewModel/savedNews_viewmodel.dart';
import 'package:mumbi_app/ViewModel/tooth_viewmodel.dart';

class LogoutViewModel {

  void destroyInstance(){
    MomViewModel.destroyInstance();
    DadViewModel.destroyInstance();
    ChildViewModel.destroyInstance();
    DiaryViewModel.destroyInstance();
    ActivityViewModel.destroyInstance();
    SavedNewsViewModel.destroyInstance();
    SavedGuidebookViewModel.destroyInstance();
    ToothViewModel.destroyInstance();
    ActionViewModel.destroyInstance();
    ChildHistoryViewModel.destroyInstance();
    PregnancyHistoryViewModel.destroyInstance();
    InjectionScheduleViewModel.destroyInstance();

    CurrentMember.id = null;
    CurrentMember.pregnancyFlag = false;
    CurrentMember.pregnancyID = null;
    CurrentMember.role = null;
  }
}