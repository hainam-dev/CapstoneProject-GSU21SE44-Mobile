import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/MyFlutterApp.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/widgets/customText.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'addRemind_view.dart';

class ListRemindScreen extends StatefulWidget {
  @override
  _ListRemindScreenState createState() => _ListRemindScreenState();
}

class _ListRemindScreenState extends State<ListRemindScreen> {
  int selectedIndex = 0;
  bool status = false;
  final List<TitledNavigationBarItem> items = [
    TitledNavigationBarItem(
        title: Text('Uống nước'), icon: MyFlutterApp.water_2),
    TitledNavigationBarItem(
        title: Text('Cho con bú'), icon: MyFlutterApp.feeding_bottle_2),
    TitledNavigationBarItem(
        title: Text('Nghe nhạc'), icon: MyFlutterApp.playlist_2),
    TitledNavigationBarItem(title: Text('Đi ngủ'), icon: MyFlutterApp.sleep_2),
    TitledNavigationBarItem(
        title: Text('Tập thể dục'), icon: MyFlutterApp.dumbell_1),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'Nhắc nhở',
          color: Colors.white,
        ),
        actions: [
          IconButton(
              onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddRemindScreen()))
                  },
              icon: Icon(Icons.add_box_outlined))
        ],
      ),
      body: Container(
        height: SizeConfig.blockSizeVertical * 100,
        width: SizeConfig.blockSizeHorizontal * 100,
        child: Column(
          children: [
            buildTitle(),
            buidListRemind(),
          ],
        ),
      ),
      bottomNavigationBar: TitledBottomNavigationBar(
        onTap: (index) => index = selectedIndex,
        curve: Curves.easeInBack,
        items: items,
        activeColor: PINK_COLOR,
        inactiveColor: Colors.blueGrey,
      ),
    );
  }

  Widget buildTitle() => Container(
      margin: EdgeInsets.symmetric(vertical: 47.0),
      height: SizeConfig.blockSizeVertical * 7,
      width: SizeConfig.blockSizeHorizontal * 90,
      child: Column(
        children: [
          Text(
            'Uống đủ nước mỗi ngày',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24.0,
              fontFamily: 'Lato',
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            'để không bị khát và mất nước các mẹ nhé',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
              fontFamily: 'Lato',
            ),
          ),
        ],
      ));

  Widget buidListRemind() => Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 11.0),
                width: SizeConfig.blockSizeHorizontal * 90,
                decoration: new BoxDecoration(
                  color: WHITE_COLOR,
                  borderRadius: new BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(remindDrink),
                      SizedBox(width: SizeConfig.safeBlockHorizontal * 7),
                      Column(
                        children: [
                          CustomText(
                            text: '06:00',
                            size: 24.0,
                            weight: FontWeight.w400,
                            color: Color.fromRGBO(97, 97, 97, 1),
                          ),
                          CustomText(
                            text: '12:00',
                            size: 24.0,
                            color: Color.fromRGBO(97, 97, 97, 1),
                            weight: FontWeight.w400,
                          ),
                          CustomText(
                            text: '15:00',
                            size: 24.0,
                            color: Color.fromRGBO(97, 97, 97, 1),
                            weight: FontWeight.w400,
                          ),
                          CustomText(
                            text: '15:00',
                            size: 24.0,
                            color: Color.fromRGBO(97, 97, 97, 1),
                            weight: FontWeight.w400,
                          ),
                          CustomText(
                            text: '15:00',
                            size: 24.0,
                            color: Color.fromRGBO(97, 97, 97, 1),
                            weight: FontWeight.w400,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: SizeConfig.safeBlockHorizontal * 20,
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.brightness_1,
                            size: 5,
                            color: PINK_COLOR,
                          ),
                          Text(
                            '2',
                            style: TextStyle(
                              color: PINK_COLOR,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: SizeConfig.safeBlockHorizontal * 15,
                      ),
                      FlutterSwitch(
                        width: SizeConfig.safeBlockHorizontal * 13,
                        height: SizeConfig.safeBlockVertical * 3.5,
                        activeColor: PINK_COLOR,
                        inactiveColor: Color.fromRGBO(224, 224, 224, 1),
                        toggleSize: 20.0,
                        value: status,
                        borderRadius: 30.0,
                        onToggle: (val) {
                          setState(() {
                            status = val;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
