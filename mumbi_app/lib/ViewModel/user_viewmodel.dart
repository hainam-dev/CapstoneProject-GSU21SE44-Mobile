import 'dart:convert';

import 'package:mumbi_app/main.dart';
import 'package:scoped_model/scoped_model.dart';

class UserViewModel extends Model{
  static Future<String> getUserID() async{
    String id;
    dynamic user = await storage.read(key: "UserInfo");
    if (user == null)
      return null;
    else {
      user = jsonDecode(user);
      id = user['data']['id'];
    }
    return id;
  }
}