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
}

class Data {
  Data({
    this.id,
    this.email,
    this.role,
    this.photo,
  });

  String id;
  String email;
  String role;
  String photo;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json['id'],
    email: json["email"],
    role: json["role"],
    photo: json["photo"],
  );

  void getInfo() async {
    dynamic user = await storage.read(key: "UserInfo");
    if (user == null)
      return null;
    else {
      user = await jsonDecode(user);
      id = user['id'];
      email = user['email'];
      photo = user['photo'];
    }
  }
}