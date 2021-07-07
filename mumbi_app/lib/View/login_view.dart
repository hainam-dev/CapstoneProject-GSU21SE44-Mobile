import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/ViewModel/login_viewmodel.dart';
import 'package:mumbi_app/Widget/splashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../main.dart';
import 'bottomNavBar_view.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  ProgressDialog pr;
  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);

    pr.style(
      message: "Đang đăng nhập, bạn vui lòng chờ trong giây lát...",
      borderRadius: 10.0,
      backgroundColor: WHITE_COLOR,
      elevation: 10.0,
      messageTextStyle:
          TextStyle(color: PINK_COLOR, fontSize: 16.0, fontFamily: 'Lato'),
    );
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
          padding: EdgeInsets.all(7.0),
          onPressed: onPressed,
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
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
                _isLoading ? null : _loginGoogle();
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

  void _loginGoogle() async {
    setState(() {
      _isLoading = true;
    });

    LoginViewModel loginViewModel = LoginViewModel();
    var userInfo;
    await pr.show();
    await loginViewModel.signInWithGoogle().then((value) => {userInfo = value});
    if (userInfo != null) {
      storage.write(key: "UserInfo", value: userInfo);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('UserInfo', userInfo);
      String roleID = jsonDecode(userInfo)['data']['role'];
      if (roleID.toString() == "role01") {
        pr.hide();
        await Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => new BotNavBar()),
            (router) => false);
      } else {
        pr.hide();
        print("Ban khong co quyen truy cap");
      }
    } else {
      // _showMsg(context, "Please sign in with FPT Education mail");
    }
    setState(() {
      _isLoading = false;
    });
  }
}
