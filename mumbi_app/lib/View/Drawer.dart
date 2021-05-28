import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/View/menuRemind.dart';
import 'package:mumbi_app/View/momInfo_view.dart';
import 'package:mumbi_app/Widget/utils.dart';

import 'BabyDiary.dart';
import 'Contact.dart';
import 'MyFamily.dart';


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
          color: getColor,
          child: ListTile(
            title: Text('Tài khoản',style: TextStyle(color: Colors.white,fontSize: 20),),
          ),
        ),
          Card(
          elevation: 0,
          margin: EdgeInsets.zero,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(motherImage),
            ),
            title: Text("Nguyễn Thị Bé Nhỏ"),
            subtitle: Text("0978 820 456"),
            trailing: Icon(Icons.arrow_forward_ios,size: 15,color: Colors.black,),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> MomInfo("Thông tin mẹ")));
            },
          ),
        ),
          SizedBox(height: 15,),
          createListTileNavigator(context, myFamily, 'Gia đình của tôi', MyFamily()),
          createListTileNavigator(context, reminder, 'Nhắc nhở', MenuRemind()),
          createListTileNavigator(context, saved, 'Đã lưu', MyFamily()),
          createListTileNavigator(context, babyDiary, 'Nhật ký của bé', BabyDiary()),
          createListTileNavigator(context, teethGrow, 'Mọc răng', MyFamily()),
          createListTileNavigator(context, contact, 'Liên Hệ Hỗ Trợ', Contact()),
          SizedBox(height: 15,),
          createListTileNavigatorNoTrailing(context, logout, 'Đăng xuất'),
        ],
      ),
    ),
  );
}





