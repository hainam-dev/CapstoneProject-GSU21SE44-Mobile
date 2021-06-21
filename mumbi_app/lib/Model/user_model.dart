import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';

import '../main.dart';

class UserModel extends Model{
  Data data;

  UserModel({
    this.data});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.email,
    this.role,
    this.photo,
  });

  String email;
  String role;
  String photo;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    email: json["email"],
    role: json["role"],
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "role": role,
    "photo": photo,
  };

  void getInfo() async {
    dynamic user = await storage.read(key: "UserInfo");
    if (user == null)
      return null;
    else {
      user = jsonDecode(user);
      email = user['email'];
      photo = user['photo'];
    }
  }
}