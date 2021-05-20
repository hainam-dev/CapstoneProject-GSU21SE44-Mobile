import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mumbi_app/Utils/constant.dart';

class FatherInfo extends StatefulWidget {
  @override
  _FatherInfoState createState() => _FatherInfoState();
}

class _FatherInfoState extends State<FatherInfo> {
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
        toolbarHeight: 48,
        title: Text(
          "Thông tin cha",
          style: TextStyle(fontFamily: 'Lato', fontSize: 20),
        ),
        backgroundColor: Color.fromRGBO(251, 103, 139, 1),
      ),
      body: Container(
        height: 2344,
        width: 1125,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 24.0),
              child: new Stack(
                fit: StackFit.loose,
                children: <Widget>[
                  new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        width: 140.0,
                        height: 140.0,
                        decoration: new BoxDecoration(
                          border: Border.all(
                              color: Color.fromRGBO(250, 101, 138, 1),
                              width: 2),
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                            image: new ExactAssetImage(IMAGE + 'Image.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 100.0, left: 100.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new CircleAvatar(
                          backgroundColor: Color.fromRGBO(251, 103, 139, 1),
                          radius: 16.0,
                          child: new Icon(
                            Icons.image_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
