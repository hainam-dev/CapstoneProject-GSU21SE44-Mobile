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
import 'package:mumbi_app/View/vaccinePrice_compare.dart';
import 'package:mumbi_app/ViewModel/child_viewmodel.dart';
import 'package:mumbi_app/ViewModel/injectionSchedule_viewmodel.dart';
import 'package:mumbi_app/Widget/customComponents.dart';
import 'package:mumbi_app/View/injectiondetail_view.dart';
import 'package:mumbi_app/Widget/customLoading.dart';
import 'package:progress_dialog/progress_dialog.dart';
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
  bool isLogin = false;
  ChildViewModel childViewModel;
  InjectionScheduleViewModel injectionScheduleViewModel;
  StateSetter _setStateLoginDialog;

  @override
  void initState() {
    super.initState();
    VaccinationRespository.getToken().then((value) async {
      if (value != null && value != "") {
        if (injectionScheduleViewModel.injectionScheduleListModel == null) {
          await getHistorySchedule();
        }
        isLogin = true;
      }
    });
    childViewModel = ChildViewModel.getInstance();
    childViewModel.getChildByID(CurrentMember.pregnancyFlag == true
        ? CurrentMember.pregnancyID
        : CurrentMember.id);
    injectionScheduleViewModel = InjectionScheduleViewModel.getInstance();
  }

  void getInjectionSchedule() {
    showCustomProgressDialog(context, "Đang lấy dữ liệu", getHistorySchedule(),
        (value) {
      return Pair(value, "Có lỗi xảy ra, vui lòng thử lại!");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lịch sử tiêm chủng'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ChildInfo(childViewModel.childModel),
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
                  _InjectionScheduleState();
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
                        getInjectionSchedule();
                      } else {
                        _loginDialog(context);
                        // injectionScheduleViewModel.getInjectionSchedule(
                        //     CurrentMember.pregnancyFlag == true
                        //         ? CurrentMember.pregnancyID
                        //         : CurrentMember.id);
                      }
                    }),
              )),
          Header(),
          InjectTable(),
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                    child: Text("So sánh giá Vaccine",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            fontStyle: FontStyle.italic,
                            color: Colors.pinkAccent)),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => VaccinePrice(),));
                    }),
              )),
        ],
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
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: Center(
                      child:
                          Text("- Chưa có lịch sử tiêm chủng được ghi nhận -")),
                )
              : Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: model.injectionScheduleListModel == null
                          ? 1
                          : model.injectionScheduleListModel.length,
                      itemBuilder: (context, index) {
                        InjectionScheduleModel injectModel =
                            model.injectionScheduleListModel[index];
                        return Body(injectModel);
                      }),
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
    ProgressDialog dialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    dialog.style(
      message: "Vui lòng đợi",
    );
    dialog.show();
    var data = await VaccinationRespository.login(
        phoneNoController.text, passController.text);
    final json = jsonDecode(data);
    //print(json);
    final success = json["code"] == 1;
    if (success) {
      isLogin = true;
      VaccinationRespository.setTokenValue(json["data"]["token"]);
      setState(() {});
      await VaccinationRespository.personListSynchronization();
      await VaccinationRespository.historyListSynchronization();
      dialog.hide();
      showCustomProgressDialog(
          context,
          "Đang lấy dữ liệu",
          injectionScheduleViewModel.getInjectionSchedule(
              CurrentMember.pregnancyFlag == true
                  ? CurrentMember.pregnancyID
                  : CurrentMember.id), (data) {
        return Pair(data, "Có lỗi xảy ra, vui lòng thử lại!");
      });
    }
  }

  _loginDialog(context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: StatefulBuilder(
                builder: (context, setState) {
                  _setStateLoginDialog = setState;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Align(alignment: Alignment.center,child: Text("Vui lòng nhập số điện thoại và mật khẩu đã đăng ký với các cơ sở tiêm chủng để cập nhật lịch sử tiêm chủng cho bé")),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: TextFormField(
                          controller: passController,
                          obscureText: isHidePassword,
                          decoration: InputDecoration(
                              icon: Icon(Icons.lock),
                              labelText: "Mật khẩu",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  width: 1,
                                ),
                              ),
                              hintText: "Mật khẩu",
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isHidePassword = !isHidePassword;
                                  });
                                },
                                icon: Icon(
                                  isHidePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              )),
                        ),
                      ),
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
                      DialogButton(
                        color: PINK_COLOR,
                        width: SizeConfig.safeBlockHorizontal * 40,
                        onPressed: () => login(),
                        child: Text(
                          "Đăng nhập",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )
                    ],
                  );
                },
              ),
            ));

    // Alert(
    //     desc:
    //         "Vui lòng nhập số điện thoại đã đăng ký để xem thông tin chi tiết lịch tiêm chủng của bé.",
    //     style: AlertStyle(
    //         descStyle: TextStyle(fontSize: 15.0),
    //         titleStyle: TextStyle(
    //             color: PINK_COLOR,
    //             fontSize: 25.0,
    //             fontWeight: FontWeight.w600)),
    //     context: context,
    //     title: "Đăng nhập",
    //     content: ).show();
  }

  Future<void> getHistorySchedule() async {
    await VaccinationRespository.historyListSynchronization();
    return injectionScheduleViewModel.getInjectionSchedule(
        CurrentMember.pregnancyFlag == true
            ? CurrentMember.pregnancyID
            : CurrentMember.id);
  }
}
