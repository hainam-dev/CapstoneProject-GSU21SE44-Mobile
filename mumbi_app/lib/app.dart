import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mumbi_app/View/bottomNavBar_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Constant/colorTheme.dart';
import 'Utils/message.dart';
import 'View/login_view.dart';
import 'Widget/splashScreen.dart';
import 'main.dart';

class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MessageView(),
            settings: RouteSettings(
              arguments: MessageArguments(message, true),
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.data.length > 0) {
        flutterLocalNotificationsPlugin.show(
            message.data.hashCode,
            message.data['title'],
            message.data['text'],
            NotificationDetails(
              android: AndroidNotificationDetails(
                  channel.id, channel.name, channel.description,
                  largeIcon: DrawableResourceAndroidBitmap('@mipmap/logo'),
                  color: PINK_COLOR,
                  icon: 'logo_notification'),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MessageView(),
          settings: RouteSettings(
            arguments: MessageArguments(message, true),
          ),
        ),
      );
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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('vi', ''),
      ],
      home: MainScreen(),
      routes: {
        '/LoginScreen': (context) => LoginScreen(),
      },
    );
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
