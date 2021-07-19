import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mumbi_app/Constant/textStyle.dart';
import 'package:mumbi_app/Repository/vaccination_respository.dart';
import 'package:mumbi_app/View/injectionSchedule.dart';
import 'package:mumbi_app/View/phoneEmpty.dart';
import 'package:mumbi_app/Widget/customComponents.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'injectionUpdatePhone_view.dart';

class InectionVaccinationLogin extends StatefulWidget {
  const InectionVaccinationLogin({Key key}) : super(key: key);

  @override
  _InectionVaccinationLoginState createState() =>
      _InectionVaccinationLoginState();
}

class _InectionVaccinationLoginState extends State<InectionVaccinationLogin> {
  bool isHidePassword = true;
  final TextEditingController passController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  bool isLogin = true;

  void login() async {
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
            context, VaccinationRespository.getMemberList(), (value1) {
          var json1 = jsonDecode(value1);
          print(json1);
          VaccinationRespository.sendPersonalInfo(json1).then((value) {
            print("sendPersonalInfo: $value");
          });
          var succ = json1["code"] == 1;
          if (succ) {
            handleMemerList(json1);
          }
          return Pair(succ, json1["message"]);
        });
      }
      return Pair(success, json["message"]);
    });
  }

  void handleMemerList(json) {
    List data = json["data"];
    for (final i in data) {
      if (i["dien_thoai"] == phoneNoController.text) {
        VaccinationRespository.setDoi_tuong_id(
            (i["doi_tuong_id"] as double).toInt());
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PhoneEmpty()),
        );
        break;
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    VaccinationRespository.getToken().then((value) {
      if (value != null && value.isNotEmpty) {
        VaccinationRespository.getDoi_tuong_id().then((value1) {
          if (value1 == null) {
            VaccinationRespository.getMemberList().then((value2) {
              var json1 = jsonDecode(value2);
              if (json1["code"] == 401) {
                VaccinationRespository.setTokenValue(null);
                showCustomProgressDialog(context, null, (_) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InectionVaccinationLogin()),
                  );
                  return Pair(false, json1["message"]);
                });
              } else {
                var succ = json1["code"] == 1;
                if (succ) {
                  handleMemerList(json1);
                }
              }
            });
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PhoneEmpty()),
            );
          }
        });
      } else {
        isLogin = false;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      return Scaffold(
        body: Container(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Đăng nhập"),
        leading: backButton(context, InjectionSchedule()),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                decoration: InputDecoration(
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
            ),
            createFieldPassword("Mật khẩu", "Mật khẩu", isHidePassword,
                passController, passwordView),
            Container(
              padding: EdgeInsets.all(16),
              child: createButtonConfirm("Đăng nhập", login),
            ),
            Stack(
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
            )
          ],
        ),
      ),
    );
  }

  void passwordView() {
    isHidePassword = !isHidePassword;
    setState(() {});
  }
}
