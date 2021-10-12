import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';

Widget getFlushBar(context,_message){
  return Flushbar(
    message:  _message,
    duration:  Duration(seconds: 2),
  )..show(context);
}