import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';

showProgressDialogue(BuildContext context) {
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(
            color: PINK_COLOR,
            backgroundColor: WHITE_COLOR,
            strokeWidth: 2,),
        ),
        SizedBox(height: 10,),
        Text("Đang xử lý...", style: TextStyle(color: WHITE_COLOR,fontSize: 20),),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context:context,
    builder: (BuildContext context) {
      return WillPopScope(
          onWillPop: null, // prevent close on back
          child: alert);
    },
  );
}