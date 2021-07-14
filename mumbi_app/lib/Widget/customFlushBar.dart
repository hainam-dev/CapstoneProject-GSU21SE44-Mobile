import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';

Widget getFlushBar(context,_title, _message){
  return Flushbar(
    title:  _title,
    message:  _message,
    duration:  Duration(seconds: 1),
  )..show(context);
}