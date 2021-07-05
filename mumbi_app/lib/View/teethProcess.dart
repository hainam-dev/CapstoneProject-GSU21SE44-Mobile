import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
// import 'package:timeline_tile/timeline_tile.dart';
import 'package:timelines/timelines.dart';



class TeethProcess extends StatefulWidget {
  const TeethProcess({Key key}) : super(key: key);

  @override
  _TeethProcessState createState() => _TeethProcessState();
}

class _TeethProcessState extends State<TeethProcess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quá trình mọc răng'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: SizedBox(
            height: 150.0,
            child: TimelineNode(
              indicator: Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: SvgPicture.asset(ic_tooth_color),
                  ),
                ),
              ),
              startConnector: SolidLineConnector(color: GREY_COLOR,thickness: 3,),
              endConnector: SolidLineConnector(color: GREY_COLOR,thickness: 3,),
            ),
          )
        )
      ),
    );
  }
}
