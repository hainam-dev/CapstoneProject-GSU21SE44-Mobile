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
      body: Column(
        children: <Widget>[
          TimelineTile(
            isFirst: true,
            // axis: TimelineAxis.horizontal,
            alignment: TimelineAlign.manual,
            lineXY: 0.25,
            // isFirst: true,
            // indicatorStyle: IndicatorStyle(
            //   width: 50,
            //   height: 50,
            //   padding: const EdgeInsets.all(50),
            //   // iconStyle: IconStyle(
            //   //   color: Colors.white,
            //   //   iconData: Icons.insert_emoticon,
            //   // ),
            //   indicator: SvgPicture.asset(ic_tooth, color: PINK_COLOR,),
            // ),
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
            // isFirst: true,
            // indicatorStyle: IndicatorStyle(
            //   width: 50,
            //   height: 50,
            //   padding: const EdgeInsets.all(50),
            //   // iconStyle: IconStyle(
            //   //   color: Colors.white,
            //   //   iconData: Icons.insert_emoticon,
            //   // ),
            //   indicator: SvgPicture.asset(ic_tooth, color: PINK_COLOR,),
            // ),
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
          // TimelineTile(
          //   alignment: TimelineAlign.left,
          //   isFirst: true,
          //   indicatorStyle: IndicatorStyle(
          //     width: 40,
          //     height: 50,
          //     padding: const EdgeInsets.all(8),
          //     indicator: Image.asset('assets/hitchhiker_2.png'),
          //   ),
          //   leftChild: Text('ahihi')
          // ),
          // SizedBox(
          //   height: 150.0,
          //   child: TimelineNode(
          //     indicator: Card(
          //       margin: EdgeInsets.zero,
          //       child: Padding(
          //         padding: EdgeInsets.all(8.0),
          //         child: SizedBox(
          //           width: 50,
          //           height: 50,
          //           child: SvgPicture.asset(ic_tooth_color),
          //         ),
          //       ),
          //     ),
          //     startConnector: SolidLineConnector(color: GREY_COLOR,thickness: 3,),
          //     endConnector: SolidLineConnector(color: GREY_COLOR,thickness: 3,),
          //   ),
          // ),
    );
  }
}
