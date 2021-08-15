import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';

showProgressDialogue(BuildContext context) {
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Center(child: Image.asset(logoApp,scale: 1.7,)),
              Center(
                child: SizedBox(
                    width: 70,
                    height: 70,
                    child: CircularProgressIndicator(
                      color: PINK_COLOR,
                      backgroundColor: WHITE_COLOR,
                      strokeWidth: 2,)
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
  showDialog(
    barrierDismissible: false,
    context:context,
    builder: (BuildContext context) {
      return WillPopScope(
          onWillPop: (){}, // prevent close on back
          child: alert);
    },
  );
}