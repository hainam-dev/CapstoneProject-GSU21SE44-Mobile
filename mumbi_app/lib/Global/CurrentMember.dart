import 'package:mumbi_app/Constant/Variable.dart';
import 'package:mumbi_app/ViewModel/user_viewmodel.dart';

class CurrentMember{
  static String id = null;
  static String role = null;
  static String pregnancyID = null;
  static bool pregnancyFlag;

  void getMomID() async{
    String momID = await UserViewModel.getUserID();
    id = momID;
    role = MOM_ROLE;
  }
}