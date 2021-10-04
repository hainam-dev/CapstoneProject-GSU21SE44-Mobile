import 'package:mumbi_app/Constant/Variable.dart';
import 'package:mumbi_app/ViewModel/user_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentMember{
  static String id = null;
  static String role = MOM_ROLE;
  static bool pregnancyFlag = false;
  static String pregnancyID = null;

  String cm_Id;
  String cm_Role;
  bool cm_PF;
  String cm_FI;

  SharedPreferences prefs;

  void getCurrentMember() async{
    prefs = await SharedPreferences.getInstance();

    cm_Id = await prefs.getString(CURRENT_MEMBER_ID);
    cm_Role = await prefs.getString(CURRENT_MEMBER_ROLE);
    cm_PF = await prefs.getBool(CURRENT_MEMBER_PREGNANCY_FLAG);
    cm_FI = await prefs.getString(CURRENT_MEMBER_PREGNANCY_ID);

    await getCurrentMemberID();
    await getCurrentMemberRole();
    await getCurrentMemberPF();
    await getCurrentMemberPI();
  }

  Future<void> getCurrentMemberID() async {
    if(cm_Id != null){
      id = cm_Id;
    }else{
      String momID = await UserViewModel.getUserID();
      id = momID;
    }
  }

  void getCurrentMemberRole() {
    if(cm_Role != null){
      role = cm_Role;
    }else{
      role = MOM_ROLE;
    }
  }

  void getCurrentMemberPF() {
    if(cm_PF == true){
      pregnancyFlag = true;
    }else{
      pregnancyFlag = false;
    }
  }

  void getCurrentMemberPI() {
    if(cm_FI != "" && cm_FI != null){
      pregnancyID = cm_FI;
    }else{
      pregnancyID = null;
    }
  }
}