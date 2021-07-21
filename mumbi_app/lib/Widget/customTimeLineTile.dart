import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Constant/textStyle.dart';
import 'package:mumbi_app/Model/tooth_model.dart';
import 'package:timeline_tile/timeline_tile.dart';

Widget firstTimeLineTile(ToothModel model){
  DateTime oDate = DateTime.tryParse(model.grownDate.toString());
  String growTime = oDate.day.toString()+"/"+oDate.month.toString() +"\n"+ oDate.year.toString();
  return TimelineTile(
    isFirst: true,
    // axis: TimelineAxis.horizontal,
    alignment: TimelineAlign.manual,
    lineXY: 0.25,
    startChild: Container(
      padding: EdgeInsets.only(top: 20, left: 16, right: 8),
      constraints: const BoxConstraints(
        minHeight:80,
      ),
      child: Text(growTime, style: SEMIBOLD_18,),
      // color: PINK_COLOR,
    ),
    indicatorStyle: IndicatorStyle(
        width: 35,
        height:35,
        color: PINK_COLOR,
        padding: const EdgeInsets.all(5),
        indicator: Container(
          decoration: BoxDecoration(
              // color: PINK_COLOR,
              border: Border.all(width: 1, color: PINK_COLOR),
              borderRadius: BorderRadius.circular(10.0)
          ),
          child: SvgPicture.asset(ic_tooth_color, width: 20, height: 20,),
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
  );
}

Widget customTimeLineTile(ToothModel model){
  DateTime oDate = DateTime.tryParse(model.grownDate.toString());
  String growTime = oDate.day.toString()+"/"+oDate.month.toString() +"\n"+ oDate.year.toString();
  return TimelineTile(
    // isFirst: true,
    // axis: TimelineAxis.horizontal,
    alignment: TimelineAlign.manual,
    lineXY: 0.25,
    startChild: Container(
      padding: EdgeInsets.only(top: 20, left: 16, right: 8),
      constraints: const BoxConstraints(
        minHeight:80,
      ),
      child: Text(growTime, style: SEMIBOLD_18,),
      // color: PINK_COLOR,
    ),
    indicatorStyle: IndicatorStyle(
        width: 35,
        height:35,
        color: PINK_COLOR,
        padding: const EdgeInsets.all(5),
        indicator: Container(
          decoration: BoxDecoration(
            // color: PINK_COLOR,
              border: Border.all(width: 1, color: PINK_COLOR),
              borderRadius: BorderRadius.circular(10.0)
          ),
          child: SvgPicture.asset(ic_tooth_color),
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
  );
}

Widget lastTimeLineTile(ToothModel model){
  DateTime oDate = DateTime.tryParse(model.grownDate.toString());
  String growTime = oDate.day.toString()+"/"+oDate.month.toString() +"\n"+ oDate.year.toString();
  return TimelineTile(
    isLast: true,
    // axis: TimelineAxis.horizontal,
    alignment: TimelineAlign.manual,
    lineXY: 0.25,
    startChild: Container(
      padding: EdgeInsets.only(top: 20, left: 16, right: 8),
      constraints: const BoxConstraints(
        minHeight:80,
      ),
      child: Text(growTime, style: SEMIBOLD_18,),
      // color: PINK_COLOR,
    ),
    indicatorStyle: IndicatorStyle(
        width: 35,
        height:35,
        color: PINK_COLOR,
        padding: const EdgeInsets.all(5),
        indicator: Container(
          decoration: BoxDecoration(
            // color: PINK_COLOR,
              border: Border.all(width: 1, color: PINK_COLOR),
              borderRadius: BorderRadius.circular(10.0)
          ),
          child: SvgPicture.asset(ic_tooth_color),
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
  );
}