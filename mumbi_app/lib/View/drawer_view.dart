import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Constant/userInfo.dart';
import 'package:mumbi_app/Model/user_model.dart';
import 'package:mumbi_app/View/menuRemind.dart';
import 'package:mumbi_app/View/momInfo_view.dart';
import 'package:mumbi_app/View/teethTrack_view.dart';
import 'package:mumbi_app/Widget/createList.dart';
import 'contact_view.dart';
import 'listBabyDiary_view.dart';
import 'myFamily_view.dart';

Widget getDrawer(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    child: Drawer(
      child: ListView(
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
            elevation: 0,
            margin: EdgeInsets.zero,
            color: PINK_COLOR,
            child: ListTile(
              title: Text(
                'Tài khoản',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          Card(
            elevation: 0,
            margin: EdgeInsets.zero,
            child: ListTile(
              leading: CircleAvatar(
                  // backgroundImage: NetworkImage(userModel.data.photo),
                  ),
              // title: Text(userModel.data.email),
              subtitle: Text("0978 820 456"),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 15,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MomInfo("Thông tin mẹ")));
              },
            ),
          ),
          SizedBox(
            height: 15,
          ),
          createListTileNavigator(
              context, myFamily, 'Gia đình của tôi', MyFamily()),
          SizedBox(
            height: 1,
          ),
          createListTileNavigator(context, reminder, 'Nhắc nhở', MenuRemind()),
          SizedBox(
            height: 1,
          ),
          createListTileNavigator(context, saved, 'Đã lưu', MyFamily()),
          SizedBox(
            height: 1,
          ),
          createListTileNavigator(
              context, babyDiary, 'Nhật ký của bé', BabyDiary()),
          SizedBox(
            height: 1,
          ),
          createListTileNavigator(context, teethGrow, 'Mọc răng', TrackTeeth()),
          SizedBox(
            height: 1,
          ),
          createListTileNavigator(
              context, contact, 'Liên Hệ Hỗ Trợ', Contact()),
          SizedBox(
            height: 15,
          ),
          createListTileNavigatorNoTrailing(context, logout, 'Đăng xuất'),
        ],
      ),
    ),
  );
}
