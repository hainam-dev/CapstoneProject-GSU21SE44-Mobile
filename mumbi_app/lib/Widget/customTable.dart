import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/textStyle.dart';

Widget createTextTitleRow(){
  return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            child: Text("Giới\n hạn\n trên")),
        Text("Giới\n hạn\n dưới"),
      ]);
}
