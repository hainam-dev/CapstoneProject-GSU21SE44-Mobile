import 'package:mumbi_app/Constant/Variable.dart';
import 'package:mumbi_app/core/auth/logout/repositories/logout_repository.dart';
import 'package:mumbi_app/core/change_member/models/change_member_model.dart';
import 'package:mumbi_app/modules/action/viewmodel/action_viewmodel.dart';
import 'package:mumbi_app/modules/activity/viewmodel/activity_viewmodel.dart';
import 'package:mumbi_app/modules/community/viewmodel/post_viewmodel.dart';
import 'package:mumbi_app/modules/family/viewmodel/child_viewmodel.dart';
import 'package:mumbi_app/modules/family/viewmodel/dad_viewmodel.dart';
import 'package:mumbi_app/modules/family/viewmodel/mom_viewmodel.dart';
import 'package:mumbi_app/modules/growing_teeth/viewmodel/teeth_viewmodel.dart';
import 'package:mumbi_app/modules/health_history/viewmodel/child_history_viewmodel.dart';
import 'package:mumbi_app/modules/diary/viewmodel/diary_viewmodel.dart';
import 'package:mumbi_app/modules/injection_schedules/repositories/injection_schedules_respository.dart';
import 'package:mumbi_app/modules/injection_schedules/viewmodel/injection_schedules_viewmodel.dart';
import 'package:mumbi_app/modules/health_history/viewmodel/pregnancy__history_viewModel.dart';
import 'package:mumbi_app/modules/guidebook/viewmodel/saved_guidebook_viewmodel.dart';
import 'package:mumbi_app/modules/news/viewmodel/saved_news_viewmodel.dart';
import 'package:mumbi_app/core/auth/login/viewmodel/user_viewmodel.dart';
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

  void destroyInstance() async {
    await deleteFcmToken();

    MomViewModel.destroyInstance();
    DadViewModel.destroyInstance();
    ChildViewModel.destroyInstance();
    DiaryViewModel.destroyInstance();
    ActivityViewModel.destroyInstance();
    SavedNewsViewModel.destroyInstance();
    SavedGuidebookViewModel.destroyInstance();
    TeethViewModel.destroyInstance();
    ActionViewModel.destroyInstance();
    ChildHistoryViewModel.destroyInstance();
    PregnancyHistoryViewModel.destroyInstance();
    InjectionScheduleViewModel.destroyInstance();
    PostViewModel.destroyInstance();
    InjectionSchedulesRepository.logout();

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
