import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mumbi_app/Constant/Variable.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/core/change_member/models/change_member_model.dart';
import 'package:mumbi_app/core/change_member/views/change_member_view.dart';
import 'package:mumbi_app/modules/diary/views/diary_view.dart';
import 'package:mumbi_app/modules/family/viewmodel/mom_viewmodel.dart';
import 'package:mumbi_app/modules/family/views/family_view.dart';
import 'package:mumbi_app/modules/family/views/parent_info_view.dart';
import 'package:mumbi_app/widgets/createList.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../View/contact_view.dart';
import '../../View/saved.dart';

Widget getDrawer(BuildContext context) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: PINK_COLOR, //or set color with: Color(0xFF0000FF)
  ));
  return Container(
    width: MediaQuery.of(context).size.width * 0.75,
    child: Drawer(
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top,
                ),
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
                      (BuildContext buildContext, Widget child,
                          MomViewModel model) {
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
                    context, myFamily, 'Gia đình của tôi', Family()),
                /*createListTileNavigator(context, reminder, 'Nhắc nhở', MenuRemind()),*/
                createListTileNavigator(context, saved, 'Đã lưu', Saved(0)),
                createListTileNavigator(
                    context,
                    diary,
                    'Nhật ký',
                    CurrentMember.role == CHILD_ROLE
                        ? Diary()
                        : ChangeAccount()),
                createListTileNavigator(
                    context, contact, 'Liên Hệ Hỗ Trợ', Contact()),
              ],
            ),
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
