import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:mumbi_app/Utils/splashScreen.dart';
import 'package:mumbi_app/View/childrenInfo.dart';
import 'package:mumbi_app/View/parentInfo_view.dart';
import 'package:mumbi_app/View/momInfo_view.dart';
import 'package:mumbi_app/ViewModel/login_viewmodel.dart';
import 'package:mumbi_app/View/homeTemp_view.dart';
import 'package:mumbi_app/Utils/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new SplashScreen(),
      routes: <String, WidgetBuilder>{
        //SPLASH_SCREEN: (BuildContext context) => new MapScreen(),
        '/LoginScreen': (BuildContext context) => new LoginScreen(),
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(1125, 2436),
        orientation: Orientation.portrait);
    return Scaffold(
      body: Container(
        height: 2436,
        width: 1125,
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: AssetImage(IMAGE + "background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(left: 32, right: 32, top: 84),
              height: 356,
              width: 311,
              child: Column(
                children: <Widget>[
                  Image.asset(
                    IMAGE + "logo.png",
                    scale: 1.2,
                  ),
                  _btnLogin()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _btnLoginStyle(Function onPressed, Text text, Image logo,
          Color backgroundColor, Color textColor) =>
      ButtonTheme(
        child: RaisedButton(
          textColor: textColor,
          color: backgroundColor,
          elevation: 0.0,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)),
          padding:
              EdgeInsets.only(top: 7.0, bottom: 7.0, right: 40.0, left: 7.0),
          onPressed: onPressed,
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              logo,
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: text,
              ),
            ],
          ),
        ),
      );

  Widget _btnLogin() => Container(
        height: 179,
        width: 311,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _btnLoginStyle(
              () async {
                await LoginViewModel().signInWithGoogle().then(
                  (value) async {
                    FirebaseAuth auth = FirebaseAuth.instance;
                    FirebaseUser user = await auth.currentUser();
                    print(value);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ChildrenInfo()));
                  },
                );
              },
              new Text(
                "Đăng nhập với google",
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lato'),
              ),
              new Image.asset(
                IMAGE + 'google_logo.png',
                height: 30.0,
                width: 30.0,
              ),
              Colors.white,
              Color.fromRGBO(79, 79, 79, 1),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 0.0, right: 0.0, top: 16.0, bottom: 0.0),
              child: _btnLoginStyle(
                () async {
                  await LoginViewModel().signInWithGoogle().then(
                        (value) async {},
                      );
                },
                new Text(
                  "Đăng nhập qua Apple ID",
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lato'),
                ),
                new Image.asset(
                  IMAGE + 'apple_logo.jpg',
                  height: 30.0,
                  width: 30.0,
                ),
                Colors.black,
                Color.fromRGBO(255, 255, 255, 1),
              ),
            ),
          ],
        ),
      );
}
