import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';

import 'action_finemotor_view.dart';
import 'action_grossmotor_view.dart';

class ActionDetails extends StatefulWidget {
  const ActionDetails({Key key}) : super(key: key);

  @override
  _ActionDetailsState createState() => _ActionDetailsState();
}

class _ActionDetailsState extends State<ActionDetails> {
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
                    Tab(
                      text: 'Thô',
                    ),
                    Tab(
                      text: 'Tinh',
                    ),
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
