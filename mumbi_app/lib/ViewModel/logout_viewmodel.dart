import 'package:mumbi_app/Global/CurrentMember.dart';
import 'package:mumbi_app/ViewModel/child_viewmodel.dart';
import 'package:mumbi_app/ViewModel/dad_viewmodel.dart';
import 'package:mumbi_app/ViewModel/diary_viewmodel.dart';
import 'package:mumbi_app/ViewModel/mom_viewmodel.dart';
import 'package:mumbi_app/ViewModel/savedNews_viewmodel.dart';
import 'package:scoped_model/scoped_model.dart';

class LogoutViewModel extends Model {

  void destroyInstance(){
    MomViewModel.destroyInstance();
    DadViewModel.destroyInstance();
    ChildViewModel.destroyInstance();
    DiaryViewModel.destroyInstance();
    SavedNewsViewModel.destroyInstance();
    SavedNewsViewModel.destroyInstance();

    CurrentMember.id = null;
    CurrentMember.role = null;
  }
}