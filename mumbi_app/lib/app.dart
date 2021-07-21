import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mumbi_app/View/bottomNavBar_view.dart';
import 'package:mumbi_app/View/teethProcess.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Constant/colorTheme.dart';
import 'Constant/progress_bar.dart';
import 'View/login_view.dart';
import 'Widget/splashScreen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: ColorTheme,
          fontFamily: 'Lato',
          iconTheme: new IconThemeData(color: Colors.white, size: 24.0),
        ),
        home: MainScreen());
  }
}

class MainScreen extends StatelessWidget {
  Future<String> get jwtOrEmpty async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userInfo = prefs.getString('UserInfo') ?? "";
    return userInfo;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: jwtOrEmpty,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return SplashScreen();
        if (snapshot.data != "") {
          var userInfo = jsonDecode(snapshot.data);
          var jwt = userInfo['data']['jwToken'].split('.');
          if (jwt.length != 3) {
            return LoginScreen();
          } else {
            var payload = json
                .decode(ascii.decode(base64.decode(base64.normalize(jwt[1]))));
            if (DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
                .isAfter(DateTime.now())) {
              return new BotNavBar();
            } else {
              return LoginScreen();
            }
          }
        } else {
          return LoginScreen();
        }
      },
    );
  }
}

class FirebaseState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, AsyncSnapshot<User> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return ProgressBarScreen();
        if (!snapshot.hasData || snapshot.data == null) return LoginScreen();
        return new BotNavBar();
      },
    );
  }
}
