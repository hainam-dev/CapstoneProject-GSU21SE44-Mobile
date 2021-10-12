import 'package:mumbi_app/modules/growing_teeth/viewmodel/teeth_viewmodel.dart';
import 'package:mumbi_app/modules/health_history/viewmodel/child_history_viewmodel.dart';
import 'package:mumbi_app/modules/diary/viewmodel/diary_viewmodel.dart';
import 'package:mumbi_app/modules/injection_schedules/viewmodel/injection_schedules_viewmodel.dart';
import 'package:mumbi_app/modules/health_history/viewmodel/pregnancy__history_viewModel.dart';

class ChangeMemberViewModel {
  void destroyInstance() {
    DiaryViewModel.destroyInstance();
    InjectionScheduleViewModel.destroyInstance();
    TeethViewModel.destroyInstance();
    ChildHistoryViewModel.destroyInstance();
    PregnancyHistoryViewModel.destroyInstance();
  }
}
