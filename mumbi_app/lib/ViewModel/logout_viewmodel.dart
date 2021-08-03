import 'package:mumbi_app/Global/CurrentMember.dart';
import 'package:mumbi_app/ViewModel/activity_viewmodel.dart';
import 'package:mumbi_app/ViewModel/child_viewmodel.dart';
import 'package:mumbi_app/ViewModel/dad_viewmodel.dart';
import 'package:mumbi_app/ViewModel/diary_viewmodel.dart';
import 'package:mumbi_app/ViewModel/mom_viewmodel.dart';
import 'package:mumbi_app/ViewModel/savedNews_viewmodel.dart';

class LogoutViewModel {

  void destroyInstance(){
    MomViewModel.destroyInstance();
    DadViewModel.destroyInstance();
    ChildViewModel.destroyInstance();
    DiaryViewModel.destroyInstance();
    ActivityViewModel.destroyInstance();
    SavedNewsViewModel.destroyInstance();
    SavedNewsViewModel.destroyInstance();

    CurrentMember.id = null;
    CurrentMember.pregnancyFlag = false;
    CurrentMember.pregnancyID = null;
    CurrentMember.role = null;
  }
}