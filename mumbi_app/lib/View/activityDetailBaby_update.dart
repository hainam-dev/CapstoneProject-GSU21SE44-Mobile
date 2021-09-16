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
        backgroundColor: WHITE_COLOR,
        appBar: AppBar(
          title: Text('Vận động'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      25.0,
                    ),
                    color: PINK_COLOR,
                  ),
                  labelColor: WHITE_COLOR,
                  unselectedLabelColor: BLACK_COLOR,
                  tabs: [
                    Tab(text: 'Thô',),
                    Tab(text: 'Tinh',),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  GrossMotorSkill(),
                  FineMotorSkill(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}

