import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Constant/textStyle.dart';
import 'package:mumbi_app/Model/tooth_model.dart';
import 'package:timeline_tile/timeline_tile.dart';
class CustomTimeLine{

}
Widget firstTimeLineTile(ToothModel model){


  DateTime oDate = DateTime.tryParse(model.grownDate.toString());
  String growTime = oDate.day.toString()+"/"+oDate.month.toString() +"\n"+ oDate.year.toString();

  String day;
  DateTime dayCurrent = model.grownDate;
  // DateTime dob = DateTime.parse("2022-07-10");
  Duration dur = DateTime.now().difference(model.grownDate);
  double durInMoth = dur.inDays/30;
  double durInDay = dur.inDays/30 - 12*dur.inDays/30/12;
  if(durInMoth < 12 && durInMoth >= 1){
    day = durInMoth.floor().toString()+" tháng " + (DateTime.now().day - dayCurrent.day).toString() +" ngày";}
  else if(durInMoth > 12){
    day = (durInMoth/12).floor().toString()+" năm " + durInDay.floor().toString()+" tháng " + (DateTime.now().day - dayCurrent.day).toString() +" ngày";
  } else if(durInMoth > 0){
    day = (DateTime.now().day - dayCurrent.day).toString() +" ngày";
  } else if(durInMoth < 0) day ="Ngày sai";

  final str = model.toothName;
  final start = "(";
  final end = ")";

  final startIndex = str.indexOf(start);
  final endIndex = str.indexOf(end, startIndex + start.length);

  String indexTooth = str.substring(startIndex + start.length, endIndex);

  final str2 = model.toothName;
  final first = '';

  final firstIndex = 0;
  final secondIndex = str.indexOf(start, firstIndex + first.length);
  String nameTooth = str.substring(firstIndex + first.length, secondIndex);



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
              child: Text(nameTooth,style: SEMIBOLD_16,textAlign: TextAlign.start)),
          Row(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white
                  ),
                  child: Text(day, style: REG_13,)),
              Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white
                  ),
                  child: Text(indexTooth, style: REG_13,)),
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

  String day;
  DateTime dayCurrent = model.grownDate;
  // DateTime dob = DateTime.parse("2022-07-10");
  Duration dur = DateTime.now().difference(model.grownDate);
  double durInMoth = dur.inDays/30;
  double durInDay = dur.inDays/30 - 12*dur.inDays/30/12;
  if(durInMoth < 12 && durInMoth >= 1){
    day = durInMoth.floor().toString()+" tháng " + (DateTime.now().day - dayCurrent.day).toString() +" ngày";}
  else if(durInMoth > 12){
    day = (durInMoth/12).floor().toString()+" năm " + durInDay.floor().toString()+" tháng " + (DateTime.now().day - dayCurrent.day).toString() +" ngày";
  } else if(durInMoth > 0){
    day = (DateTime.now().day - dayCurrent.day).toString() +" ngày";
  }else if(durInMoth < 0) day ="Ngày sai";

  final str = model.toothName;
  final start = "(";
  final end = ")";

  final startIndex = str.indexOf(start);
  final endIndex = str.indexOf(end, startIndex + start.length);

  String nameTooth = str.substring(startIndex + start.length, endIndex);

  final str2 = model.toothName;
  final first = '';

  final firstIndex = 0;
  final secondIndex = str.indexOf(start, firstIndex + first.length);
  String indexTooth = str.substring(firstIndex + first.length, secondIndex);


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
    endChild: Container(
      padding: EdgeInsets.only(top:20, left: 8),
      child: Column(
        children: <Widget>[
          Align(
              alignment: Alignment.topLeft,
              child: Text(indexTooth,style: SEMIBOLD_16,textAlign: TextAlign.start)),
          Row(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white
                  ),
                  child: Text(day, style: REG_13,)),
              Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white
                  ),
                  child: Text(nameTooth, style: REG_13,)),
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

  String day;
  DateTime dayCurrent = model.grownDate;
  // DateTime dob = DateTime.parse("2022-07-10");
  Duration dur = DateTime.now().difference(model.grownDate);
  double durInMoth = dur.inDays/30;
  double durInDay = dur.inDays/30 - 12*dur.inDays/30/12;
  if(durInMoth < 12 && durInMoth >= 1){
    day = durInMoth.floor().toString()+" tháng " + (DateTime.now().day - dayCurrent.day).toString() +" ngày";}
  else if(durInMoth > 12){
    day = (durInMoth/12).floor().toString()+" năm " + durInDay.floor().toString()+" tháng " + (DateTime.now().day - dayCurrent.day).toString() +" ngày";
  } else if(durInMoth > 0){
    day = (DateTime.now().day - dayCurrent.day).toString() +" ngày";
  } else if(durInMoth < 0) day ="Ngày sai";

  final str = model.toothName;
  final start = "(";
  final end = ")";

  final startIndex = str.indexOf(start);
  final endIndex = str.indexOf(end, startIndex + start.length);

  String nameTooth = str.substring(startIndex + start.length, endIndex);

  final str2 = model.toothName;
  final first = '';

  final firstIndex = 0;
  final secondIndex = str.indexOf(start, firstIndex + first.length);
  String indexTooth = str.substring(firstIndex + first.length, secondIndex);

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
              child: Text(indexTooth,style: SEMIBOLD_16,textAlign: TextAlign.start)),
          Row(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white
                  ),
                  child: Text(day, style: REG_13,)),
              Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white
                  ),
                  child: Text(nameTooth, style: REG_13,)),
            ],
          )
        ],
      ),

    ),
  );
}