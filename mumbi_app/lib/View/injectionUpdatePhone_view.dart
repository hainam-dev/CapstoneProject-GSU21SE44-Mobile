import 'dart:convert';

import 'package:charts_flutter/flutter.dart';
import 'package:flutter/src/painting/basic_types.dart' as Basic_types;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mumbi_app/Constant/textStyle.dart';
import 'package:mumbi_app/Repository/vaccination_respository.dart';
import 'package:mumbi_app/View/injectionSchedule.dart';
import 'package:mumbi_app/View/injectionUpdateToken_view.dart';
import 'package:mumbi_app/Widget/customComponents.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'injectionUpdatePassword.dart';
import 'injectionVaccinationLogin_view.dart';

class InjectionUpdatePhone extends StatefulWidget {
  final bool isRecover;
  const InjectionUpdatePhone({Key key, this.isRecover = false})
      : super(key: key);

  @override
  _InjectionUpdatePhoneState createState() => _InjectionUpdatePhoneState();
}

class _InjectionUpdatePhoneState extends State<InjectionUpdatePhone> {
  bool check = false;
  String veridicationId;
  final phoneNoController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void onNextBtn() {
    if (phoneNoController.text.length < 10) {
      return;
    }
    //0902741611
    //Navigator.push(context, MaterialPageRoute(builder: (context) => InjectionUpdateToken(phoneNo: phoneNoController.text)), );
    showCustomProgressDialog(
        context,
        widget.isRecover
            ? VaccinationRespository.getOTPRecoveryPass(phoneNoController.text)
            : VaccinationRespository.checkPhoneNo(phoneNoController.text),
        (data) {
      var jsonObject = jsonDecode(data);
      print(jsonObject);
      var success = jsonObject['code'] == 1;
      if (success) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  InjectionUpdateToken(phoneNo: phoneNoController.text)),
        );
      }
      return Pair(success, jsonObject['message']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.isRecover ? "Quên mật khẩu" : "Lịch Tiêm chủng"),
          leading: backButton(context, InectionVaccinationLogin())),
      body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              createTextTitle(widget.isRecover
                  ? "Vui lòng nhập số điện thoại đã đăng ký"
                  : "Vui lòng nhập số điện thoại đã đăng ký để xem thông tin chi tiết lịch tiêm chủng của bé."),
              Container(
                padding: EdgeInsets.only(top: 16, bottom: 16),
                child: Form(
                  key: formKey,
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
              ),
              createButtonConfirm("Tiếp tục", onNextBtn),
            ],
          )),
    );
  }
}
