import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/View/BotNavBar.dart';
import 'package:mumbi_app/View/childrenInfo_view.dart';
import 'package:mumbi_app/View/fatherInfo_view.dart';
import 'package:mumbi_app/View/menuRemind.dart';
import 'package:mumbi_app/ViewModel/login_viewmodel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mumbi_app/Widget/splashScreen.dart';

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
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        height: SizeConfig.blockSizeVertical * 100,
        width: SizeConfig.blockSizeHorizontal * 100,
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: AssetImage(backgroundApp),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(left: 32, right: 32, top: 84),
              height: SizeConfig.blockSizeVertical * 60,
              width: SizeConfig.blockSizeHorizontal * 90,
              child: Column(
                children: <Widget>[
                  Image.asset(
                    logoApp,
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
        height: SizeConfig.safeBlockVertical * 20,
        width: SizeConfig.safeBlockHorizontal * 100,
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
                        MaterialPageRoute(builder: (context) => BotNavBar()));
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
                logoGoogle,
                height: SizeConfig.safeBlockVertical * 5,
                width: SizeConfig.safeBlockHorizontal * 8,
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
                  logoFacebook,
                  height: SizeConfig.safeBlockVertical * 5,
                  width: SizeConfig.safeBlockHorizontal * 8,
                ),
                Colors.black,
                Color.fromRGBO(255, 255, 255, 1),
              ),
            ),
          ],
        ),
      );
}
