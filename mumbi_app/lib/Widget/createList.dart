import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/View/babyDiaryDetails_view.dart';
import 'package:mumbi_app/View/bottomNavBar_view.dart';
import 'package:mumbi_app/View/login_view.dart';
import 'package:mumbi_app/ViewModel/login_viewmodel.dart';
import 'package:mumbi_app/ViewModel/logout_viewmodel.dart';

Widget createListTile(BuildContext context, String _imageName, String _text) {
  return Card(
    elevation: 0,
    margin: EdgeInsets.zero,
    child: ListTile(
      leading: Image(
        image: AssetImage(_imageName),
        height: 30,
        width: 30,
      ),
      title: Text(_text),
    ),
  );
}

Widget createListTileWithBlueTextTrailing(
    String _imageName, String _title, String _textTrailing) {
  return Card(
    elevation: 0,
    margin: EdgeInsets.zero,
    child: ListTile(
      leading: Image(
        image: AssetImage(_imageName),
        height: 30,
        width: 30,
      ),
      title: Text(_title),
      trailing: Text(
        _textTrailing,
        style: TextStyle(color: BLUE_COLOR),
      ),
    ),
  );
}

Widget createListTileDiaryPost(String _imageName, String _title, String _time) {
  return Card(
    elevation: 0,
    margin: EdgeInsets.zero,
    child: ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 23,
        child: CircleAvatar(
          radius: 22,
          backgroundImage: AssetImage(_imageName),
        ),
      ),
      title: Text(_title),
      subtitle: Text(_time),
    ),
  );
}

Widget createTitleCard(String _text) {
  return Card(
    elevation: 0,
    margin: EdgeInsets.zero,
    child: ListTile(
        leading: Text(
      _text,
      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
    )),
  );
}

Widget createTitle(String _text) {
  return Column(
    children: [
      Text(
        _text,
        style: TextStyle(
            color: Color.fromRGBO(33, 33, 33, 1),
            fontWeight: FontWeight.w700,
            fontSize: 20),
      ),
    ],
  );
}

Widget createButtonTextImage(String _text, String _image) {
  return FlatButton(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    onPressed: () => {},
    color: Colors.transparent,
    padding: EdgeInsets.all(10.0),
    child: Column(
      // Replace with a Row for horizontal icon + text
      children: <Widget>[
        Image(image: AssetImage(_image)),
        SizedBox(height: 8),
        Text(
          _text,
          style: TextStyle(fontSize: 14),
        )
      ],
    ),
  );
}

Widget createListTileHome(BuildContext context, Color _color, String _imageName,
    String _text, String _subText, Widget _screen) {
  return Card(
    elevation: 0,
    color: _color,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          leading: Image(
            image: AssetImage(_imageName),
            height: SizeConfig.blockSizeVertical * 20,
            width: SizeConfig.blockSizeHorizontal * 20,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _text,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text(
                _subText,
                style: TextStyle(color: GREY_COLOR, fontSize: 14.0),
              ),
              SizedBox(height: 10.0),
              /*LinearPercentIndicator(
                backgroundColor: WHITE_COLOR,
                width: SizeConfig.blockSizeHorizontal * 50,
                lineHeight: 8.0,
                percent: 0.6,
                progressColor: PINK_COLOR,
              ),*/
              // Text(
              //   "Tìm hiểu thêm",
              //   style: TextStyle(color: BLUE_COLOR, fontSize: 13.0),
              // ),
            ],
          ),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => _screen));
          },
        ),
      ],
    ),
  );
}

item(
  Icon _icon,
  String _name,
) {
  return BottomNavigationBarItem(
    icon: _icon,
    title: Text(
      _name,
      style: TextStyle(fontWeight: FontWeight.w600),
    ),
  );
}

Widget createListTileSelectedAccount(
    BuildContext context, String _imageName, String _title, String _subtitle) {
  return Card(
    elevation: 0,
    margin: EdgeInsets.zero,
    child: ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 23,
        child: CircleAvatar(
          radius: 22,
          backgroundImage: AssetImage(_imageName),
        ),
      ),
      title: Text(_title),
      subtitle: Text(
        _subtitle,
        style: TextStyle(color: PINK_COLOR),
      ),
      trailing: Icon(
        Icons.check,
        size: 25,
        color: PINK_COLOR,
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BotNavBar()));
      },
    ),
  );
}

Widget createListTileUnselectedAccount(
    BuildContext context, String _imageName, String _title, String _subtitle) {
  return Card(
    elevation: 0,
    margin: EdgeInsets.zero,
    child: ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 19,
        child: CircleAvatar(
          radius: 19,
          backgroundImage: AssetImage(_imageName),
        ),
      ),
      title: Text(_title),
      subtitle: Text(
        _subtitle,
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BotNavBar()));
      },
    ),
  );
}

Widget createListTileNavigator(
    BuildContext context, String _imageName, String _text, Widget _screen) {
  return Card(
    elevation: 0,
    margin: EdgeInsets.zero,
    child: ListTile(
      leading: Image(
        image: AssetImage(_imageName),
        height: SizeConfig.blockSizeVertical * 8,
        width: SizeConfig.blockSizeHorizontal * 8,
      ),
      title: Text(_text),
      trailing: Icon(Icons.arrow_forward_ios, size: 15),
      onTap: () {
        Navigator.of(context).pop();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => _screen));
      },
    ),
  );
}

Widget createListTileNavigatorNoTrailing(
    BuildContext context, String _imageName, String _text) {
  return Card(
    elevation: 0,
    margin: EdgeInsets.zero,
    child: ListTile(
      leading: Image(
        image: AssetImage(_imageName),
        height: SizeConfig.blockSizeVertical * 8,
        width: SizeConfig.blockSizeHorizontal * 8,
      ),
      title: Text(_text),
      onTap: () async {
        await LoginViewModel().signOut();
        LogoutViewModel().destroyInstance();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyApp()));
        print("Logout");
      },
    ),
  );
}

Widget createEmptyDiary(BuildContext context) {
  return Align(
    alignment: Alignment.topCenter,
    child: Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage(emptyDiary),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Chưa có bài nhật ký nào",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.9,
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "- Nhật ký là dữ liệu cá nhân của bạn, và những người khác không thể xem được",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}

Widget createDiaryItem(BuildContext context, String _time, String _content) {
  return GestureDetector(
    onTap: () => Navigator.push(
        context, MaterialPageRoute(builder: (context) => BabyDiaryDetails())),
    child: Container(
      padding: EdgeInsets.all(30),
      constraints: BoxConstraints(
        maxHeight: double.infinity,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(diaryFrame),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ngày " + _time,
            style: TextStyle(
              color: PINK_COLOR,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            _content,
            style: TextStyle(
              color: LIGHT_DARK_GREY_COLOR,
              fontSize: 16,
            ),
          ),
        ],
      ),
    ),
  );
}
