import 'package:flutter/material.dart';
import 'package:mumbi_app/View/parentInfo_view.dart';

class MomInfo extends StatefulWidget {
final appbarTitle;
final model;
MomInfo(this.appbarTitle, this.model);
  @override
  _MomInfoState createState() => _MomInfoState(this.appbarTitle, this.model);
}

class _MomInfoState extends State<MomInfo> {
  final appbarTitle;
  final model;
  _MomInfoState(this.appbarTitle, this.model);
  @override
  Widget build(BuildContext context) {
    return ParentInfo(appbarTitle,model);
  }
}
