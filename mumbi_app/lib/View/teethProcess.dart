                                                                                                 import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Constant/textStyle.dart';
import 'package:timeline_tile/timeline_tile.dart';
// import 'package:timelines/timelines.dart';



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
        child: Column(
          children: <Widget>[
            TimelineTile(
              isFirst: true,
              // axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.manual,
              lineXY: 0.25,
              startChild: Container(
                padding: EdgeInsets.only(top: 20, left: 8, right: 8),
                constraints: const BoxConstraints(
                  minHeight:80,
                ),
                child: Text("30/07/2010", style: SEMIBOLD_16,),
                // color: PINK_COLOR,
              ),
              indicatorStyle: IndicatorStyle(
                width: 30,
                height:30,
                color: PINK_COLOR,
                padding: const EdgeInsets.all(5),
                indicator: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue
                  ),
                  child: SvgPicture.asset(ic_tooth_color, fit: BoxFit.cover),
                )
              ),
              // leftChild: Text('ahihi'),
              endChild: Container(
                padding: EdgeInsets.only(top:20, left: 8),
                child: Column(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text("Răng cửa giữa",style: SEMIBOLD_16,textAlign: TextAlign.start)),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white
                            ),
                            child: Text("12 tháng 4 ngày", style: REG_13,)),
                        Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.white
                            ),
                            child: Text("Răng thứ mấy", style: REG_13,)),
                      ],
                    )
                  ],
                ),

              ),
            ),
            TimelineTile(
              // isFirst: true,
              // axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.manual,
              lineXY: 0.25,
              startChild: Container(
                padding: EdgeInsets.only(top:20, left: 8, right: 8),
                constraints: const BoxConstraints(
                  minHeight:80,
                ),
                child: Text("30/07/2010",style: SEMIBOLD_16),
                // color: PINK_COLOR,
              ),
              indicatorStyle: IndicatorStyle(
                  width: 30,
                  color: PINK_COLOR,
                  padding: const EdgeInsets.all(5),
                  iconStyle: IconStyle(
                    color: Colors.white,
                    iconData: (Icons.event),
                  )
              ),
              // leftChild: Text('ahihi'),
              endChild: Container(
                padding: EdgeInsets.only(top:20, left: 8),
                child: Column(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text("Răng cửa giữa",style: SEMIBOLD_16,textAlign: TextAlign.start)),
                    Row(
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.white
                            ),
                            child: Text("12 tháng 4 ngày", style: REG_13,)),
                        Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.white
                            ),
                            child: Text("Răng thứ mấy", style: REG_13,)),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ]),
      ),
    );
  }
}
