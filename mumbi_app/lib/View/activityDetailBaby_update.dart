import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/View/babyDevelopment_view.dart';
import 'package:mumbi_app/View/babyFineMotorSkills.dart';
import 'package:mumbi_app/View/babyGrossMotorSkills.dart';
import 'package:mumbi_app/Widget/customComponents.dart';


class ActivityDetail extends StatefulWidget {
  const ActivityDetail({Key key}) : super(key: key);

  @override
  _ActivityDetailState createState() => _ActivityDetailState();
}

class _ActivityDetailState extends State<ActivityDetail> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cập nhật hoạt động'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(child: Text('Vận động thô'),),
              Tab(child: Text('Vận động tinh'),),
            ],
          ),
          leading: backButton(context, BabyDevelopment()),
        ),
        body: TabBarView(
          children: <Widget>[
            GrossMotorSkill(),
            FineMotorSkill(),
          ],
        ),
      ),
    );
  }

}

