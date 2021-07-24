import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Global/CurrentMember.dart';
import 'package:mumbi_app/Model/diary_model.dart';
import 'package:mumbi_app/Utils/datetime_convert.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/View/babyDiaryDetails_view.dart';
import 'package:mumbi_app/View/bottomNavBar_view.dart';
import 'package:mumbi_app/View/dashboard_view.dart';
import 'package:mumbi_app/ViewModel/diary_viewmodel.dart';
import 'package:mumbi_app/ViewModel/login_viewmodel.dart';
import 'package:mumbi_app/ViewModel/logout_viewmodel.dart';
import 'package:mumbi_app/Widget/customFlushBar.dart';

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

Widget createListTileDiaryPost(String _imageURL, String _name, bool publicFlag) {
  return Card(
    elevation: 0,
    margin: EdgeInsets.zero,
    child: ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: LIGHT_GREY_COLOR,
        backgroundImage: CachedNetworkImageProvider(_imageURL),
      ),
      title: Text(_name,style: TextStyle(fontWeight: FontWeight.w600),),
      subtitle: Row(
        children: [
          Text(DateTimeConvert.getCurrentDay(),style: TextStyle(color: LIGHT_DARK_GREY_COLOR),),
          SizedBox(width: 6),
          if(publicFlag == true)
          Icon(
            Icons.fiber_manual_record,
            color: GREY_COLOR,
            size: 6,
          ),
          SizedBox(width: 6),
          if(publicFlag == true) Text("Chia sẻ cộng đồng: Đã bật"),
        ],
      )
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

Widget createButtonTextImageLink(
    BuildContext context, String _text, String _image, Widget _screen) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => _screen));
    },
    child: FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      // onPressed: () => {},
      color: Colors.transparent,
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Image(image: AssetImage(_image),filterQuality: FilterQuality.high,),
          SizedBox(height: 8),
          Text(
            _text,
            style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),
          )
        ],
      ),
    ),
  );
}

Widget createListTileHome(BuildContext context, Color _color, String _imageName,
    String _text, String _subText, Widget _screen) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => _screen));
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
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            leading: Image(
              image: AssetImage(_imageName),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
                ),
                SizedBox(height: 8.0),
                if(_subText != "")
                Text(
                  _subText,
                  style: TextStyle(color: GREY_COLOR, fontSize: 14.0),
                ),
                //SizedBox(height: 10.0),
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

Widget createListTileSelectedAccount(
    BuildContext context, String _imageURL, String _title,String id ,String role) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
    child: Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 23,
          child: CircleAvatar(
            radius: 22,
            backgroundImage: CachedNetworkImageProvider(_imageURL),
          ),
        ),
        title: Row(
          children: [
            Text(
                _title
            ),
            if(CurrentMember.id == id)
            Text(
              " (Đang chọn)",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: PINK_COLOR),
            ),
          ],
        ),
        subtitle: Text(
          role
        ),
        trailing: CurrentMember.id == id
          ? Icon(
          Icons.check,
          size: 25,
          color: PINK_COLOR,
          )
        :SizedBox.shrink(),
        onTap: () async{
          CurrentMember.id = id;
          CurrentMember.role = role;
          DiaryViewModel.destroyInstance();
          await Future.delayed(Duration(seconds: 1));
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) => BotNavBar(),));
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
        color: LIGHT_GREY_COLOR,
        elevation: 2,
        margin: EdgeInsets.zero,
        child: ListTile(
          leading: CircleAvatar(
            radius: 22,
            backgroundImage: CachedNetworkImageProvider(_imageURL),
            child: CircleAvatar(
              radius: 22,
              backgroundColor: GREY_COLOR.withOpacity(0.4),
            ),
          ),
          title: Text(_title, style: TextStyle(color: GREY_COLOR.withOpacity(0.8)),),
          subtitle: Text(_subtitle, style: TextStyle(color: GREY_COLOR.withOpacity(0.8)),),
        ),
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
          SizedBox(height: 8,),
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

Widget createDiaryItem(BuildContext context, DiaryModel diaryModel) {
  return GestureDetector(
    onTap: () => Navigator.push(
        context, MaterialPageRoute(builder: (context) => BabyDiaryDetails(diaryModel))),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(10, 3, 10, 7),
      child: Card(
        elevation: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(diaryModel.imageURL != null)
              Container(
                color: BLACK_COLOR,
                child: Center(
                  child: CachedNetworkImage(imageUrl: diaryModel.imageURL),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        DateTimeConvert.getDayOfWeek(diaryModel.createTime)
                            + DateTimeConvert.convertDatetimeFullFormat(diaryModel.createTime),
                        style: TextStyle(color: LIGHT_DARK_GREY_COLOR,fontSize: 18,fontWeight: FontWeight.w600),),
                      SizedBox(width: 3,),
                      if(diaryModel.publicFlag == true && diaryModel.approvedFlag == true
                      || diaryModel.publicFlag == true && diaryModel.approvedFlag == false)
                        Icon(Icons.fiber_manual_record,color: LIGHT_DARK_GREY_COLOR,size: 5,),
                      SizedBox(width: 3,),
                      if(diaryModel.publicFlag == true && diaryModel.approvedFlag == true)
                        Text("Đã chia sẻ",style: TextStyle(color: LIGHT_DARK_GREY_COLOR,),),
                      if(diaryModel.publicFlag == true && diaryModel.approvedFlag == false)
                        Text("Đang chờ duyệt",style: TextStyle(color: LIGHT_DARK_GREY_COLOR,),)
                    ],
                  ),
                  SizedBox(height: 5,),
                  Text(
                    diaryModel.diaryContent,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: BLACK_COLOR,fontSize: 15
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

// Widget create(){
//   return DataRow(
//     selected: true,
//     cells: <DataCell>[
//       DataCell(Text('Tháng 1')),
//       DataCell(
//           Row(
//             // mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('1.28'),
//                 Text('1.26'),
//               ])),
//       DataCell(
//           Row(
//             // mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('1.28'),
//                 Text('1.26'),
//               ])),
//       DataCell(
//           Row(
//             // mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('1.28'),
//                 Text('1.26'),
//               ])),
//     ],
//   );
// }
