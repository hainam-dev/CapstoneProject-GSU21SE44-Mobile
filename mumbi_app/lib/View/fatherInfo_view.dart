import 'package:flutter/material.dart';
import 'package:mumbi_app/View/parentInfo_view.dart';

class FatherInfo extends StatefulWidget {
  final appbarTitle;
  final model;
  FatherInfo(this.appbarTitle, this.model);
  @override
  _FatherInfoState createState() => _FatherInfoState(this.appbarTitle, this.model);
}

class _FatherInfoState extends State<FatherInfo> {
  final appbarTitle;
  final model;
  _FatherInfoState(this.appbarTitle, this.model);
  @override
  Widget build(BuildContext context) {
    return ParentInfo(appbarTitle,model);
  }
}