import 'package:mumbi_app/ViewModel/user_viewmodel.dart';

class CurrentMember{
  static String id = null;
  static String role = "Mẹ";

  void getMomID() async{
    String momID = await UserViewModel.getUserID();
    id = momID;
  }
}