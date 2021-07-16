import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/textStyle.dart';
import 'package:mumbi_app/Repository/vaccination_respository.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/View/injectionSchedule.dart';
import 'package:mumbi_app/View/injectionUpdatePassword.dart';
import 'package:mumbi_app/Widget/customComponents.dart';
import 'injectionUpdatePhone_view.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class InjectionUpdateToken extends StatefulWidget {
  final String phoneNo;
  final bool isRecovery;
  const InjectionUpdateToken({Key key, @required this.phoneNo, this.isRecovery = false}) : super(key: key);

  @override
  _InjectionUpdateTokenState createState() => _InjectionUpdateTokenState();
}

class _InjectionUpdateTokenState extends State<InjectionUpdateToken> {
  bool disableConfirm = false;

  void clear(){
    Navigator.push(context, PageRouteBuilder(transitionDuration: Duration(seconds: 0), pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) { return InjectionUpdateToken(phoneNo: widget.phoneNo,); },),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Xác nhận số điện thoại"),
        leading: backButton(context, InjectionUpdatePhone()),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            createTextTitle(
                "Một mã OTP đã được gửi đến số điện thoại ***${widget.phoneNo.substring(widget.phoneNo.length-3, widget.phoneNo.length)}. Vui lòng nhập mã ở đây"),
            Container(
              padding: EdgeInsets.only(top: 16, bottom: 16),
              child: OTPTextField(
                margin: EdgeInsets.symmetric(horizontal: 0),
                length: 6,
                width: MediaQuery.of(context).size.width,
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldWidth: 50,
                fieldStyle: FieldStyle.box,
                outlineBorderRadius: 15,
                style: TextStyle(fontSize: 17),
                onChanged: (pin) {
                  //print("Changed: " + pin);
                },
                onCompleted: (pin) {
                  //print("Completed: " + pin);
                  setState(() {
                    disableConfirm = true;
                  });
                  showCustomProgressDialog(context, VaccinationRespository.activeOTP(widget.phoneNo, pin), (data){
                    var json = jsonDecode(data);
                    print(json);
                    var success = json['code'] == 1;
                    if (success){
                      VaccinationRespository.setTokenValue(json["data"]["token"]);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => InectionUpdatePassword(phoneNo: widget.phoneNo, isRecovery: widget.isRecovery)), );
                    }else{
                      clear();
                    }
                    return Pair(success, json['message']);
                  });
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 16),
              child: Row(
                children: <Widget>[
                  // Container(
                  //   width: SizeConfig.blockSizeVertical * 35,
                  //   child: createTextBlueHyperlink(
                  //       context, "Đổi số điện thoại", InjectionUpdatePhone()),
                  // ),
                  createTextBlue(context, "Nhập lại mã", clear)
                ],
              ),
            ),
            createButtonConfirm("Hoàn tất",  disableConfirm ? null: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InectionUpdatePassword(phoneNo: widget.phoneNo, isRecovery: widget.isRecovery)),
              );
            })
          ],
        ),
      ),
    );
  }
}