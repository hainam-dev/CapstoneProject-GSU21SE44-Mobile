import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../main.dart';

class UserModel {
  Data data;

  UserModel({this.data});

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

  @override
  String toString() {
    // TODO: implement toString
    return '{${this.email}, ${this.photo}}';
  }
}
