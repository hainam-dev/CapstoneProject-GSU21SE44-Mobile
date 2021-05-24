import 'package:flutter/material.dart';
import 'package:mumbi_app/View/parentInfo_view.dart';

class MomInfo extends StatefulWidget {
final appbarTitle;
MomInfo(this.appbarTitle);
  @override
  _MomInfoState createState() => _MomInfoState(this.appbarTitle);
}

class _MomInfoState extends State<MomInfo> {
  final appbarTitle;
  _MomInfoState(this.appbarTitle);
  @override
  Widget build(BuildContext context) {
    return ParentInfo(appbarTitle);
  }
}
