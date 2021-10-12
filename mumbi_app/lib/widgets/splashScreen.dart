import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/core/walk_through/home_bottom_navigation.dart';
import 'package:mumbi_app/core/auth/login/views/login_view.dart';

class SplashScreen extends StatefulWidget {
  final loggedIn;
  const SplashScreen(this.loggedIn);

  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  AnimationController animationController;
  Animation<double> animation;

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    if (this.mounted) {
      // check whether the state object is in tree
      setState(() {
        if (widget.loggedIn == false) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoginScreen()),
              (Route<dynamic> route) => false);
        } else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => BotNavBar()),
              (Route<dynamic> route) => false);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));

    animation = new CurvedAnimation(
        parent: animationController, curve: Curves.fastLinearToSlowEaseIn);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();
    _visible = !_visible;
    startTime();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 2436,
        width: 1125,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundApp),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new SvgPicture.asset(
              textLogoApp,
              width: animation.value * 60,
              height: animation.value * 60,
            ),
          ],
        ),
      ),
    );
  }
}
