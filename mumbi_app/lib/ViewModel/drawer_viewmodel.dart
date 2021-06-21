import 'dart:convert';

import 'package:mumbi_app/main.dart';
import 'package:scoped_model/scoped_model.dart';

class DrawerViewModel extends Model {
  String accountID;
  String photo;

  DrawerViewModel() {
    getUserAccountID();
  }

  void getUserAccountID() async {
    dynamic user = await storage.read(key: "UserInfo");
    if (user == null)
      return null;
    else {
      user = jsonDecode(user);
      accountID = user['email'];
      photo = user['photo'];
    }
    notifyListeners();
  }
}
