import 'dart:convert';

import 'package:mumbi_app/Model/user_model.dart';

import '../main.dart';

getInfo() async {
  dynamic user = await storage.read(key: "UserInfo");
  if (user == null)
    return null;
  else {
    UserModel userModel = UserModel.fromJson(jsonDecode(user));
    return userModel;
  }
}
