import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/View/menuRemind.dart';
import 'package:mumbi_app/View/momInfo_view.dart';
import 'package:mumbi_app/View/parentInfo_view.dart';
import 'package:mumbi_app/View/teethTrack_view.dart';
import 'package:mumbi_app/ViewModel/parent_viewmodel.dart';
import 'package:mumbi_app/Widget/createList.dart';
import 'package:scoped_model/scoped_model.dart';
import 'contact_view.dart';
import 'listBabyDiary_view.dart';
import 'myFamily_view.dart';

Widget getDrawer(BuildContext context) {
  return Container(
      width: MediaQuery.of(context).size.width*0.75,
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
            ScopedModel(
            model: ParentViewModel(),
              child: ScopedModelDescendant(builder: (BuildContext buildContext, Widget child, ParentViewModel model){
                model.getMomByID();
              return model.momModel == null ? Center(child: CircularProgressIndicator()) : Card(
                  elevation: 0,
                  margin: EdgeInsets.zero,
                  child: ListTile(
                    leading: CircleAvatar(
                        backgroundImage: NetworkImage(model.momModel.image == null ? "" :  model.momModel.image),
                        ),
                    title: Text(model.momModel.fullName == null ? "" :  model.momModel.fullName),
                    subtitle: model.momModel.phoneNumber == null ? null : Text(model.momModel.phoneNumber),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                      color: Colors.black,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ParentInfo("Thông tin mẹ",model.momModel)));
                    },
                  ),
              );
            }),),
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
