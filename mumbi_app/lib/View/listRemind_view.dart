import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/MyFlutterApp.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/Widget/customText.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

class ListRemindScreen extends StatefulWidget {
  @override
  _ListRemindScreenState createState() => _ListRemindScreenState();
}

class _ListRemindScreenState extends State<ListRemindScreen> {
  int selectedIndex = 0;
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
        toolbarHeight: SizeConfig.blockSizeVertical * 6,
        title: CustomText(
          text: 'Nhắc nhở',
          size: 20.0,
          color: Colors.white,
        ),
        actions: [
          FlatButton.icon(
            onPressed: () => {},
            icon: Image.asset(iconPlus),
            label: Text(''),
          )
        ],
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
}
