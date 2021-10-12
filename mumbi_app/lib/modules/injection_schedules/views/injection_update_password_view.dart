import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mumbi_app/modules/injection_schedules/repositories/injection_schedules_respository.dart';
import 'package:mumbi_app/widgets/customComponents.dart';

import 'injection_schedules_view.dart';

class InectionUpdatePassword extends StatefulWidget {
  final bool isRecovery;
  final String phoneNo;
  const InectionUpdatePassword(
      {Key key, @required this.phoneNo, this.isRecovery = false})
      : super(key: key);

  @override
  _InectionUpdatePasswordState createState() => _InectionUpdatePasswordState();
}

class _InectionUpdatePasswordState extends State<InectionUpdatePassword> {
  bool isHidePassword = true;
  final TextEditingController passController = TextEditingController();
  final TextEditingController passConfirmController = TextEditingController();

  void updatePass() async {
    if (passController.text != passConfirmController.text) {
      showCustomProgressDialog(context, "Vui lòng đợi", null, (data) {
        return Pair(false, "Xác nhận mật khẩu không khớp");
      });
      return;
    }
    showCustomProgressDialog(
        context,
        "Vui lòng đợi",
        widget.isRecovery
            ? InjectionSchedulesRepository.changePassByToken(
                widget.phoneNo, passController.text)
            : InjectionSchedulesRepository.createPassByToken(
                widget.phoneNo, passController.text), (data) {
      var json = jsonDecode(data);
      print(json);
      var success = json['code'] == 1;
      if (success) {
        InjectionSchedulesRepository.setTokenValue(json["data"]["token"]);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InjectionSchedule()),
        );
      }
      return Pair(success, json['message']);
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => InjectionSchedule()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cập nhật mật khẩu"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: <Widget>[
            createFieldPassword("Nhập mật khẩu sử dụng truy cập hệ thống (*)",
                "Mật khẩu", isHidePassword, passController, passwordView),
            createFieldPassword("Nhập lại mật khẩu", "Mật khẩu", isHidePassword,
                passConfirmController, passwordView),
            Container(
              padding: EdgeInsets.all(16),
              child: createButtonConfirm("Hoàn tất", updatePass),
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
