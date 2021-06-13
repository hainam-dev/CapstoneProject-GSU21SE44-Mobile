import 'dart:convert';

import 'package:mumbi_app/Model/user_model.dart';

import '../main.dart';

getInfo(Object model) async {
  dynamic user = await storage.read(key: "UserInfo");
  if (user == null)
    return null;
  else {
    model = UserModel.fromJson(jsonDecode(user));
  }
}
