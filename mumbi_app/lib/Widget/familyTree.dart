import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimeLine_Page extends StatefulWidget {
  @override
  _TimeLine_PageState createState() => _TimeLine_PageState();
}

class _TimeLine_PageState extends State<TimeLine_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[],
        ),
      ),
    );
  }
}
