import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Constant/textStyle.dart';
import 'package:mumbi_app/Global/CurrentMember.dart';
import 'package:mumbi_app/Model/child_model.dart';
import 'package:mumbi_app/Model/injectionSchedule_model.dart';
import 'package:mumbi_app/Repository/vaccination_respository.dart';
import 'package:mumbi_app/Utils/rebuildAllChildren.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/ViewModel/child_viewmodel.dart';
import 'package:mumbi_app/ViewModel/injectionSchedule_viewmodel.dart';
import 'package:mumbi_app/Widget/customComponents.dart';
import 'package:mumbi_app/View/injectiondetail_view.dart';
import 'package:mumbi_app/Widget/customLoading.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:scoped_model/scoped_model.dart';
import 'injectionUpdatePhone_view.dart';

class InjectionSchedule extends StatefulWidget {
  @override
  _InjectionScheduleState createState() => _InjectionScheduleState();
}

class _InjectionScheduleState extends State<InjectionSchedule> {
  bool isHidePassword = true;
  final TextEditingController passController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  bool isLogin = true;
  ChildViewModel childViewModel;
  InjectionScheduleViewModel injectionScheduleViewModel;
  @override
  void initState() {
    super.initState();
    childViewModel = ChildViewModel.getInstance();
    childViewModel.getChildByID(CurrentMember.pregnancyFlag == true
        ? CurrentMember.pregnancyID
        : CurrentMember.id);

    injectionScheduleViewModel = InjectionScheduleViewModel.getInstance();
    injectionScheduleViewModel.getInjectionSchedule(
        CurrentMember.pregnancyFlag == true
            ? CurrentMember.pregnancyID
            : CurrentMember.id);

    VaccinationRespository.getToken().then((value) {
      if (value != null && value.isNotEmpty) {
        return isLogin = true;
      } else {
        isLogin = false;
        setState(() {
          _loginDialog(context);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: childViewModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child, ChildViewModel model) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Lịch sử tiêm chủng'),
            ),
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ChildInfo(model.childModel),
                if (isLogin)
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      child: Text("Logout"),
                      onPressed: () {
                        VaccinationRespository.logout();
                        setState(() {
                          isLogin = false;
                        });
                        rebuildAllChildren(context);
                      },
                    ),
                  ),
                Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                          child: Text("Cập nhật lịch sử tiêm chủng",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue)),
                          onTap: () {
                            if (isLogin) {
                              setState(() {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) async {
                                  showCustomProgressDialog(
                                      context,
                                      VaccinationRespository
                                          .historyListSynchronization(),
                                      (value) {
                                    //do something...............

                                    return Pair(true, "");
                                  });
                                });
                                rebuildAllChildren(context);
                              });
                            } else {
                              _loginDialog(context);
                            }
                          }),
                    )),
                Header(),
                InjectTable(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget ChildInfo(ChildModel childModel) {
    return ListTile(
        leading: childModel == null
            ? CircleAvatar(radius: 22, backgroundColor: LIGHT_GREY_COLOR)
            : CircleAvatar(
                radius: 22,
                backgroundColor: LIGHT_GREY_COLOR,
                backgroundImage:
                    CachedNetworkImageProvider(childModel.imageURL),
              ),
        title: Text(
          childModel == null ? "..." : childModel.fullName,
          style: TextStyle(fontWeight: FontWeight.w600),
        ));
  }

  Widget InjectTable() {
    return ScopedModel(
      model: injectionScheduleViewModel,
      child: ScopedModelDescendant(
        builder: (BuildContext context, Widget child,
            InjectionScheduleViewModel model) {
          return model.injectionScheduleListModel == null
              ? loadingProgress()
              : Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: model.injectionScheduleListModel == null
                        ? 1
                        : model.injectionScheduleListModel.length,
                    itemBuilder: (context, index) {
                      if (model.injectionScheduleListModel == null) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          child: Center(
                              child: Text(
                                  "- Chưa có lịch sử tiêm chủng được ghi nhận -")),
                        );
                      } else {
                        InjectionScheduleModel injectModel =
                            model.injectionScheduleListModel[index];
                        return Body(injectModel);
                      }
                    },
                  ),
                );
        },
      ),
    );
  }

  Widget Header() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
      child: Row(
        children: <Widget>[
          HeaderItem(25, "Ngày tiêm"),
          HeaderItem(45, "Kháng nguyên"),
          HeaderItem(15, "Mũi thứ"),
          Expanded(child: HeaderItem(5, "")),
        ],
      ),
    );
  }

  Widget HeaderItem(num size, String name) {
    return Container(
      width: SizeConfig.safeBlockHorizontal * size,
      child: Center(
        child: Text(name,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: WHITE_COLOR, fontSize: 15, fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget Body(InjectionScheduleModel model) {
    return Column(
      children: [
        ListTile(
            title: Row(children: <Widget>[
          BodyItem(25, CutDate(model.injectionDate), model),
          BodyItem(45, model.antigen, model),
          BodyItem(10, model.orderOfInjection.toString(), model),
          Expanded(child: BodyItem(5, "", model)),
        ])),
        Divider(
          height: 1,
          thickness: 1,
        ),
      ],
    );
  }

  Widget BodyItem(num size, String name, InjectionScheduleModel model) {
    return Container(
      width: SizeConfig.safeBlockHorizontal * size,
      child: name != ""
          ? Text(name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ))
          : IconButton(
              icon: Icon(Icons.visibility),
              color: BLACK_COLOR,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InjectionDetail(model)));
              },
            ),
    );
  }

  String CutDate(String date) {
    var str = date;
    var parts = str.split(' ');
    var date2 = parts.sublist(1).join(' ');
    return date2;
  }

  void login() async {
    Navigator.pop(context);
    showCustomProgressDialog(
        context,
        VaccinationRespository.login(
            phoneNoController.text, passController.text), (value) {
      final json = jsonDecode(value);
      //print(json);
      final success = json["code"] == 1;
      if (success) {
        VaccinationRespository.setTokenValue(json["data"]["token"]);
        showCustomProgressDialog(
            context, VaccinationRespository.personListSynchronization(),
            (value1) {
          return Pair(success, json["message"]);
        });
      }
      return Pair(success, json["message"]);
    });
  }

  _loginDialog(context) {
    Alert(
        desc:
            "Vui lòng nhập số điện thoại đã đăng ký để xem thông tin chi tiết lịch tiêm chủng của bé.",
        style: AlertStyle(
            descStyle: TextStyle(fontSize: 15.0),
            titleStyle: TextStyle(
                color: PINK_COLOR,
                fontSize: 25.0,
                fontWeight: FontWeight.w600)),
        context: context,
        title: "Đăng nhập",
        content: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              keyboardType: TextInputType.phone,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              decoration: InputDecoration(
                  icon: Icon(Icons.account_circle),
                  labelStyle: SEMIBOLDPINK_16,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      width: 1,
                    ),
                  ),
                  hintText: "Nhập số điện thoại"),
              controller: phoneNoController,
            ),
            createFieldPassword("Mật khẩu", "Mật khẩu", isHidePassword,
                passController, passwordView),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: createTextBlueHyperlink(
                        context, "Đăng ký", InjectionUpdatePhone()),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: createTextBlueHyperlink(
                        context,
                        "Quên mật khẩu?",
                        InjectionUpdatePhone(
                          isRecover: true,
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            color: PINK_COLOR,
            width: SizeConfig.safeBlockHorizontal * 40,
            onPressed: () => login(),
            child: Text(
              "LOGIN",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  void passwordView() {
    setState(() {
      isHidePassword = !isHidePassword;
    });
  }
}
