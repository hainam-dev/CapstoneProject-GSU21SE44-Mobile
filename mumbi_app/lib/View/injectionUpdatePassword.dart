import 'package:flutter/material.dart';
import 'package:mumbi_app/View/injectionSchedule.dart';
import 'package:mumbi_app/View/phoneEmpty.dart';
import 'package:mumbi_app/Widget/customComponents.dart';

class InectionUpdatePassword extends StatefulWidget {
  const InectionUpdatePassword({Key key}) : super(key: key);

  @override
  _InectionUpdatePasswordState createState() => _InectionUpdatePasswordState();
}

class _InectionUpdatePasswordState extends State<InectionUpdatePassword> {
  bool isHidePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cập nhật mật khẩu"),
        leading: backButton(context,InjectionSchedule()),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: <Widget>[
            createFieldPassword("Nhập mật khẩu sử dụng truy cập hệ thống (*)","Mật khẩu",isHidePassword, passwordView),
            createFieldPassword("Nhập lại mật khẩu","Mật khẩu",isHidePassword, passwordView),
            Container(
              padding: EdgeInsets.all(16),
              child: createButtonConfirm("Hoàn tất", (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PhoneEmpty()),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
  void passwordView(){
   isHidePassword = !isHidePassword;
   setState(() {

   });
  }
}


