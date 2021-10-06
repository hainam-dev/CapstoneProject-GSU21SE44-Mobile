import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/ViewModel/login_viewmodel.dart';
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
        type: ProgressDialogType.Normal, isDismissible: false,);

    pr.style(
      message: "Đang xử lý, vui lòng đợi trong giây lát...",
      borderRadius: 10.0,
      backgroundColor: WHITE_COLOR,
      elevation: 10.0,
      messageTextStyle:
          TextStyle(color: PINK_COLOR, fontSize: 16.0,),
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
        child: Column(
          children: <Widget>[
            SizedBox(height: 240,),
            SvgPicture.asset(
              textLogoApp,height: 50,
            ),
            SizedBox(height: 70,),
            _btnLogin()
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
          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45,vertical: 13),
            child: new Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                logo,
                SizedBox(width: 10,),
                text,
              ],
            ),
          ),
        ),
      );

  Widget _btnLogin() => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Column(
          children: [
            _btnLoginStyle(
              () async {
                _isLoading ? null : _loginGoogle();
              },
              new Text(
                "Đăng nhập qua google",
                style: TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lato'),
              ),
              new Image.asset(
                logoGoogle,
                height: 30,
                width: 30,
              ),
              Colors.white,
              Color.fromRGBO(79, 79, 79, 1),
            ),
            /*Padding(
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
            ),*/
          ],
        ),
      );

  void _loginGoogle() async {
    _isLoading = true;

    LoginViewModel loginViewModel = LoginViewModel();
    var userInfo;
    await loginViewModel.signInWithGoogle().then((value) => {userInfo = value});
    if (userInfo != null) {
      await pr.show();
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
    _isLoading = false;
  }
}
