import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/textStyle.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/View/injectionSchedule.dart';
import 'package:mumbi_app/View/injectionUpdatePassword.dart';
import 'package:mumbi_app/Widget/customComponents.dart';
import 'injectionUpdatePhone_view.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';


class InjectionUpdateToken extends StatefulWidget {
  const InjectionUpdateToken({Key key}) : super(key: key);

  @override
  _InjectionUpdateTokenState createState() => _InjectionUpdateTokenState();
}

class _InjectionUpdateTokenState extends State<InjectionUpdateToken> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Xác nhận số điện thoại"),
        leading: backButton(context,InjectionUpdatePhone()),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            createTextTitle("Chúng tôi vừa gửi  một mã OTP đến số điện thoại ***101. Vui lòng nhập mã ở đây"),
            Container(
              padding: EdgeInsets.only(top:16, bottom: 16),
              child: OTPTextField(
                length: 5,
                width: MediaQuery.of(context).size.width,
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldWidth: 55,
                fieldStyle: FieldStyle.box,
                outlineBorderRadius: 15,
                style: TextStyle(fontSize: 17),
                onChanged: (pin) {
                  print("Changed: " + pin);
                },
                onCompleted: (pin) {
                  print("Completed: " + pin);
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 16),
              child: Row(
                children: <Widget>[
                  Container(
                    width: SizeConfig.blockSizeVertical *35,
                    child:  createTextBlueHyperlink(context, "Đổi số điện thoại",InjectionUpdatePhone()),
                  ),
                  createTextBlue(context, "Nhập lại mã",(){

                  })
                ],
              ),
            ),
            createButtonConfirm("Hoàn tất", (){
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InectionUpdatePassword()),
              );
            })
          ],
        ),

      ),
    );
  }
}

