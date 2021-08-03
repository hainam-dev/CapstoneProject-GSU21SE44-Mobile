import 'package:mumbi_app/ViewModel/diary_viewmodel.dart';

class ChangeAccountViewModel{

  void destroyInstance(){
    DiaryViewModel.destroyInstance();
  }
}