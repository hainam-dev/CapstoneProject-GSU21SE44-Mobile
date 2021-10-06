import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mumbi_app/Constant/Variable.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Global/CurrentMember.dart';
import 'package:mumbi_app/Model/diary_model.dart';
import 'package:mumbi_app/Repository/vaccination_respository.dart';
import 'package:mumbi_app/Utils/calculation.dart';
import 'package:mumbi_app/Utils/datetime_convert.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/View/bottomNavBar_view.dart';
import 'package:mumbi_app/View/login_view.dart';
import 'package:mumbi_app/ViewModel/changeAccount_viewmodel.dart';
import 'package:mumbi_app/ViewModel/login_viewmodel.dart';
import 'package:mumbi_app/ViewModel/logout_viewmodel.dart';
import 'package:mumbi_app/Widget/customConfirmDialog.dart';
import 'package:mumbi_app/Widget/customProgressDialog.dart';
import 'package:mumbi_app/main.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app.dart';

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

Widget createListTileDiaryPost(
    String _imageURL, String _name) {
  return Card(
    elevation: 0,
    margin: EdgeInsets.zero,
    child: ListTile(
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: LIGHT_GREY_COLOR,
          backgroundImage: CachedNetworkImageProvider(_imageURL),
        ),
        title: Text(
          _name,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Row(
          children: [
            Text(
              DateTimeConvert.getCurrentDay(),
              style: TextStyle(color: LIGHT_DARK_GREY_COLOR),
            ),
          ],
        )),
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

Widget createButtonTextImageLink(
    BuildContext context, String _text, String _image, Widget _screen) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => _screen));
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
      ),
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          SvgPicture.asset(_image),
          SizedBox(height: 8),
          Text(
            _text,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          )
        ],
      ),
    ),
  );
}

Widget createListTileHome(BuildContext context, Color _color, String _imageName,
    String _text, String _subText, num day, String role,
    {Function onClick}) {
  return GestureDetector(
    onTap: () {
      onClick();
    },
    child: Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Card(
        elevation: 0,
        color: _color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            leading: SvgPicture.asset(_imageName),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _text,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  // overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
                ),
                if (_subText != "")
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      _subText,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      style: TextStyle(color: GREY_COLOR, fontSize: 14.0),
                    ),
                  ),
                if (role == PREGNANCY_ROLE)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      day > 0 ? "${day} ngày đề gặp bé" : "Bé của bạn đã ra đời chưa?",
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      style: TextStyle(color: GREY_COLOR, fontSize: 14.0),
                    ),
                  ),
                if (role == PREGNANCY_ROLE)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    child: LinearPercentIndicator(
                      padding: EdgeInsets.zero,
                      backgroundColor: WHITE_COLOR,
                      width: SizeConfig.blockSizeHorizontal * 53,
                      percent: getOpposite(calculatePercent(PREGNANCY_DAY, day > 0 ? day : 0)),
                      progressColor: PINK_COLOR,
                    ),
                  ),
                /*Text(
                  "Tìm hiểu thêm",
                  style: TextStyle(color: BLUE_COLOR, fontSize: 13.0),
                ),*/
              ],
            ),
          ),
        ),
      ),
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

Widget createListTileSelectedAccount(BuildContext context, String _imageURL,
    String _title, String id, String pregnancyId, String role) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
    child: Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: CurrentMember.id == id ? PINK_COLOR : LIGHT_DARK_GREY_COLOR.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.zero,
      child: ListTile(
        leading: Stack(
          children: [
            CircleAvatar(
              backgroundColor:
              CurrentMember.id == id ? PINK_COLOR : Colors.transparent,
              radius: 23,
              child: CircleAvatar(
                radius: 22,
                backgroundImage: CachedNetworkImageProvider(_imageURL),
              ),),
          ],
        ),
        title: Text(
          _title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Row(
          children: [
            Text(role == MOM_ROLE && pregnancyId != "" && pregnancyId != null  ? "Mẹ bầu" : role),
            if (CurrentMember.id == id)
              Text(
                " (Đang chọn)",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: PINK_COLOR),
              ),
          ],
        ),
        trailing: CurrentMember.id == id
            ? Icon(
          Icons.check,
          size: 25,
          color: PINK_COLOR,
        )
            : SizedBox.shrink(),
        onTap: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          if (pregnancyId != null && pregnancyId != "") {
            CurrentMember.id = id;
            await prefs.setString(CURRENT_MEMBER_ID, id);
            CurrentMember.pregnancyFlag = true;
            await prefs.setBool(CURRENT_MEMBER_PREGNANCY_FLAG, true);
            CurrentMember.pregnancyID = pregnancyId;
            await prefs.setString(CURRENT_MEMBER_PREGNANCY_ID, pregnancyId);
          } else {
            CurrentMember.id = id;
            await prefs.setString(CURRENT_MEMBER_ID, id);
            CurrentMember.pregnancyFlag = false;
            await prefs.setBool(CURRENT_MEMBER_PREGNANCY_FLAG, false);
            CurrentMember.pregnancyID = null;
            await prefs.setString(CURRENT_MEMBER_PREGNANCY_ID, "");
          }
          CurrentMember.role = role;
          await prefs.setString(CURRENT_MEMBER_ROLE, role);
          await ChangeAccountViewModel().destroyInstance();
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
              BotNavBar()), (Route<dynamic> route) => false);
        },
      ),
    ),
  );
}

Widget createListTileUnselectedAccount(
    BuildContext context, String _imageURL, String _title, String _subtitle) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
    child: Card(
      elevation: 0,
      color: LIGHT_GREY_COLOR,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: LIGHT_DARK_GREY_COLOR.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 22,
          backgroundImage: CachedNetworkImageProvider(_imageURL),
          child: CircleAvatar(
            radius: 22,
            backgroundColor: GREY_COLOR.withOpacity(0.4),
          ),
        ),
        title: Text(
          _title,
          style: TextStyle(color: GREY_COLOR.withOpacity(0.8)),
        ),
        subtitle: Text(
          _subtitle,
          style: TextStyle(color: GREY_COLOR.withOpacity(0.8)),
        ),
      ),
    ),
  );
}

Widget createListTileNavigator(
    BuildContext context, String _imageName, String _text, Widget _screen) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1),
    child: Card(
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
        showConfirmDialog(context, "Đăng xuất", "Bạn có muốn đăng xuất khỏi tài khoản này?",
            ContinueFunction: () async {
              await LogoutViewModel().destroyInstance();
              await LoginViewModel().signOut();
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  MyApp()), (Route<dynamic> route) => false);
            });
      },
    ),
  );
}

Widget createEmptyDiary(BuildContext context) {
  return Align(
    alignment: Alignment.topCenter,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
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
                  SvgPicture.asset(emptyDiary),
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
            height: 8,
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
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
    ),
  );
}

Widget createDiaryItem(BuildContext context, DiaryModel diaryModel,
    {Function onClick}) {
  return GestureDetector(
    onTap: () {
      onClick();
    },
    child: Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Stack(
        children: [
          Card(
            elevation: 1,
            shadowColor: GREY_COLOR,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text("Ngày ${DateTimeConvert.getDay(diaryModel.createTime)} "
                                    "tháng ${DateTimeConvert.getMonth(diaryModel.createTime)}, "
                                    "${DateTimeConvert.getYear(diaryModel.createTime)}",
                                  style: TextStyle( fontSize: 19.0, color: DARK_PINK_COLOR,fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  children: [
                                    Text("vào lúc ${DateTimeConvert.getTime(diaryModel.createTime)}",
                                      style: TextStyle( fontSize: 14.0, color: LIGHT_DARK_GREY_COLOR),
                                    ),
                                    if (diaryModel.imageURL != null && diaryModel.imageURL != "" && CountImage(diaryModel.imageURL) >= 1)
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 3),
                                            child: Icon(
                                              Icons.fiber_manual_record,color: GREY_COLOR,size: 6,
                                            ),
                                          ),
                                          Text(
                                            CountImage(diaryModel.imageURL).toString(),style: TextStyle(color: LIGHT_DARK_GREY_COLOR,fontSize: 16),
                                          ),
                                          Icon(
                                            Icons.photo_outlined,color: LIGHT_DARK_GREY_COLOR,size: 15,
                                          ),
                                        ],
                                      )
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Text(
                                  diaryModel.diaryContent,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: BLACK_COLOR,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (diaryModel.imageURL != null && diaryModel.imageURL != "")
                          Stack(
                            children: [
                              SvgPicture.asset(
                                rectFrame,height: 115,
                              ),
                              Positioned(
                                top: 38,
                                left: 19,
                                child: CachedNetworkImage(
                                  imageUrl: diaryModel.imageURL.split(";").first,
                                  fit: BoxFit.cover,
                                  height: 58,
                                  width: 77,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: SvgPicture.asset(
              edgeFrame,height: 40,
            ),
          ),
        ],
      ),
    ),
  );
}

num CountImage(String url){
  List<String> list = new List();
  list = url.split(";");
  num imageCount = list.length;
  return imageCount;
}