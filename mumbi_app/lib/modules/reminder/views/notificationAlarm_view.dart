import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Utils/size_config.dart';

class Counter extends GetxController {
  RxInt count = 5.obs;
  void add() {
    count + 5;
  }

  void sub() {
    count - 5;
  }
}

class NotificationAlarmScreen extends StatefulWidget {
  @override
  _NotificationAlarmScreenState createState() =>
      _NotificationAlarmScreenState();
}

class _NotificationAlarmScreenState extends State<NotificationAlarmScreen> {
  final counter = Get.put(Counter());
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        height: SizeConfig.blockSizeVertical * 100,
        width: SizeConfig.blockSizeHorizontal * 100,
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: AssetImage(backgroundAlarm),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: SizeConfig.blockSizeVertical * 40,
              width: SizeConfig.blockSizeHorizontal * 80,
              margin: EdgeInsets.only(top: 150.0),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: AssetImage(circleAlarm),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                          image: AssetImage(alarmDrink), fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 3,
                  ),
                  Text(
                    '06:00',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 72,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Lato',
                        color: WHITE_COLOR),
                  ),
                  Text(
                    'Giờ uống nước',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Lato',
                        color: WHITE_COLOR),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 10,
            ),
            RawMaterialButton(
              onPressed: () {},
              elevation: 1.0,
              child: Icon(
                Icons.cancel_rounded,
                size: 64.0,
              ),
            ),
            buildBottomButton(),
          ],
        ),
      ),
    );
  }

  Widget buildBottomButton() => Container(
        margin: EdgeInsets.only(top: 82),
        width: SizeConfig.safeBlockHorizontal * 85,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Opacity(
              opacity: (counter.count <= 5) ? 0.0 : 1,
              child: IconButton(
                onPressed: () {
                  (counter.count > 5) ? counter.sub() : null;
                  setState(() {
                    NotificationAlarmScreen();
                  });
                },
                icon: Icon(
                  Icons.remove,
                  size: 32,
                ),
              ),
            ),
            Container(
              width: 163.0,
              height: 38.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0x4cffffff),
              ),
              child: Center(
                child: Obx(
                  () => Text(
                    "Tạm dừng ${counter.count} phút",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: "Lato",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                counter.add();
                setState(() {
                    NotificationAlarmScreen();
                  });
              },
              icon: Icon(
                Icons.add,
                size: 32,
              ),
            ),
          ],
        ),
      );
}
