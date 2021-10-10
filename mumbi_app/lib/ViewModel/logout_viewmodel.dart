import 'package:mumbi_app/Constant/Variable.dart';
import 'package:mumbi_app/Global/CurrentMember.dart';
import 'package:mumbi_app/Repository/logout_repository.dart';
import 'package:mumbi_app/Repository/vaccination_respository.dart';
import 'package:mumbi_app/ViewModel/action_viewmodel.dart';
import 'package:mumbi_app/ViewModel/activity_viewmodel.dart';
import 'package:mumbi_app/ViewModel/childHistory_viewmodel.dart';
import 'package:mumbi_app/ViewModel/child_viewmodel.dart';
import 'package:mumbi_app/ViewModel/community_viewmodel.dart';
import 'package:mumbi_app/ViewModel/dad_viewmodel.dart';
import 'package:mumbi_app/ViewModel/diary_viewmodel.dart';
import 'package:mumbi_app/ViewModel/injectionSchedule_viewmodel.dart';
import 'package:mumbi_app/ViewModel/mom_viewmodel.dart';
import 'package:mumbi_app/ViewModel/pregnancyViewModel.dart';
import 'package:mumbi_app/ViewModel/savedGuidebook_viewmodel.dart';
import 'package:mumbi_app/ViewModel/savedNews_viewmodel.dart';
import 'package:mumbi_app/ViewModel/tooth_viewmodel.dart';
import 'package:mumbi_app/ViewModel/user_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutViewModel {

  Future<void> deleteFcmToken() async {
    String userId = await UserViewModel.getUserID();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String fcmToken = await prefs.getString(FCM_TOKEN);
    try {
      await LogoutRepository.apiDeleteFcmToken(userId, fcmToken);
      await prefs.remove(FCM_TOKEN);
    } catch (e) {
      print("error: " + e.toString());
    }
  }

  void destroyInstance() async{
    await deleteFcmToken();

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
    CommunityViewModel.destroyInstance();
    VaccinationRespository.logout();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    CurrentMember.id = null;
    prefs.remove(CURRENT_MEMBER_ID);
    CurrentMember.pregnancyFlag = false;
    prefs.remove(CURRENT_MEMBER_PREGNANCY_FLAG);
    CurrentMember.pregnancyID = null;
    prefs.remove(CURRENT_MEMBER_PREGNANCY_ID);
    CurrentMember.role = null;
    prefs.remove(CURRENT_MEMBER_ROLE);
  }
}