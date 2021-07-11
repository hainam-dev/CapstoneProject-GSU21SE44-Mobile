import 'package:mumbi_app/ViewModel/child_viewmodel.dart';
import 'package:mumbi_app/ViewModel/dad_viewmodel.dart';
import 'package:mumbi_app/ViewModel/diary_viewmodel.dart';
import 'package:scoped_model/scoped_model.dart';

class LogoutViewModel extends Model {

  void destroyInstance(){
    DadViewModel.destroyInstance();
    ChildViewModel.destroyInstance();
    DiaryViewModel.destroyInstance();
  }
}