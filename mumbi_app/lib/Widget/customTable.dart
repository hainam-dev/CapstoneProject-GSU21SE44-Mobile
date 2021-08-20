import 'package:flutter/material.dart';

Widget createTextTitleRow() {
  return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(child: Text("Giới\n hạn\n trên")),
        Text("Giới\n hạn\n dưới"),
      ]);
}
