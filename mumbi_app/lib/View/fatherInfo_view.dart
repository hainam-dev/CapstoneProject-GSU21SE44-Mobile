import 'package:flutter/material.dart';
import 'package:mumbi_app/View/parentInfo_view.dart';

class FatherInfo extends StatefulWidget {
  final appbarTitle;
  FatherInfo(this.appbarTitle);
  @override
  _FatherInfoState createState() => _FatherInfoState(this.appbarTitle);
}

class _FatherInfoState extends State<FatherInfo> {
  final appbarTitle;
  _FatherInfoState(this.appbarTitle);
  @override
  Widget build(BuildContext context) {
    return ParentInfo(appbarTitle);
  }
}