import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Global/CurrentMember.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/View/menuRemind.dart';
import 'package:mumbi_app/View/parentInfo_view.dart';
import 'package:mumbi_app/View/teethTrack_view.dart';
import 'package:mumbi_app/ViewModel/mom_viewmodel.dart';
import 'package:mumbi_app/Widget/createList.dart';
import 'package:scoped_model/scoped_model.dart';
import 'changeAccount_view.dart';
import 'contact_view.dart';
import 'savedPost_view.dart';
import 'diary_view.dart';
import 'myFamily_view.dart';

Widget getDrawer(BuildContext context) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: PINK_COLOR, //or set color with: Color(0xFF0000FF)
  ));
  return Container(
    width: MediaQuery.of(context).size.width * 0.75,
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
            model: MomViewModel.getInstance(),
            child: ScopedModelDescendant(builder:
                (BuildContext buildContext, Widget child, MomViewModel model) {
              model.getMomByID();
              return model.momModel == null
                  ? loadingUserInfoListTile()
                  : Card(
                      elevation: 0,
                      margin: EdgeInsets.zero,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: CachedNetworkImageProvider(
                              model.momModel.imageURL),
                        ),
                        title: Text(
                          model.momModel.fullName,
                          maxLines: 1,
                        ),
                        subtitle: model.momModel.phoneNumber == null ||
                                model.momModel.phoneNumber == ""
                            ? null
                            : Text(model.momModel.phoneNumber),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Colors.black,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ParentInfo(
                                      "Thông tin mẹ",
                                      model.momModel,
                                      "Update")));
                        },
                      ),
                    );
            }),
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
          createListTileNavigator(context, saved, 'Đã lưu', SavedPost(0)),
          SizedBox(
            height: 1,
          ),
          createListTileNavigator(context, babyDiary, 'Nhật ký của bé',
              CurrentMember.role == "Con" ? BabyDiary() : ChangeAccount()),
          SizedBox(
            height: 1,
          ),
          createListTileNavigator(context, teethGrow, 'Mọc răng', TeethTrack()),
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

Widget loadingUserInfoListTile() {
  return Card(
    elevation: 0,
    margin: EdgeInsets.zero,
    child: ListTile(
      leading: CircleAvatar(
        backgroundColor: LIGHT_GREY_COLOR,
      ),
      title: Container(
        width: SizeConfig.blockSizeHorizontal * 1,
        height: SizeConfig.blockSizeVertical * 0.5,
        color: LIGHT_GREY_COLOR,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 15,
        color: Colors.black,
      ),
    ),
  );
}
