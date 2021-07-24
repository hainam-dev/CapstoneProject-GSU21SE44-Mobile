import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mumbi_app/View/bottomNavBar_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Constant/colorTheme.dart';
import 'Constant/progress_bar.dart';
import 'View/login_view.dart';
import 'Widget/splashScreen.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging messaging;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      print(value);
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification.body);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification.body);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Notification"),
              content: Text(event.notification.body),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
  }

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
