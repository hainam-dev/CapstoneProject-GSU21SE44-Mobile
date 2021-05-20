import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mumbi_app/ViewModel/login_viewmodel.dart';

import 'login_view.dart';

class HomeTemp extends StatelessWidget {
  final name;
  final email;

  HomeTemp(this.name, this.email);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(1125, 2436),
        orientation: Orientation.portrait);
    return Scaffold(
      appBar: AppBar(
        title: Text('Mumbi App'),
      ),
      body: Container(
        height: 2436,
        width: 1125,
        child: Column(
          children: [
            Text(
                '$name \n $email \n height ${ScreenUtil().screenHeight}dp \n width ${ScreenUtil().screenWidth}dp'),
            RaisedButton(
              textColor: Colors.red,
              color: Colors.blue,
              onPressed: () async {
                await LoginViewModel().signOutGoogle();
                Navigator.pop(
                    context, MaterialPageRoute(builder: (context) => MyApp()));
                print("Logout");
              },
            )
          ],
        ),
      ),
    );
  }
}
