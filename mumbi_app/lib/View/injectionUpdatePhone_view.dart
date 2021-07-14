import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/textStyle.dart';
import 'package:mumbi_app/View/injectionSchedule.dart';
import 'package:mumbi_app/Widget/customComponents.dart';
import 'injectionUpdateToken_view.dart';
import 'package:mumbi_app/Widget/customInputNumber.dart';

class InjectionUpdatePhone extends StatefulWidget {
  const InjectionUpdatePhone({Key key}) : super(key: key);


  @override
  _InjectionUpdatePhoneState createState() => _InjectionUpdatePhoneState();
}

class _InjectionUpdatePhoneState extends State<InjectionUpdatePhone> {
  bool check = false;
  String phoneNo, veridicationId;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lịch Tiêm chủng"),
        leading: backButton(context,InjectionSchedule())
      ),
      body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              createTextTitle("Vui lòng nhập số điện thoại đã đăng ký để xem thông tin chi tiết lịch tiêm chủng của bé."),
              Container(
                padding: EdgeInsets.only(top:16, bottom: 16),
                child: Form(
                  key: formKey,
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration:
                    InputDecoration(
                        labelStyle: SEMIBOLDPINK_16,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            width: 1,
                          ),
                        ),
                        hintText: "Nhập số điện thoại"
                    ),
                    onChanged: (value){
                      this.phoneNo = value;
                    },
                  ),
                ),
              ),
              createButtonConfirm("Tiếp tục", (){
                verifyPhone(phoneNo);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InjectionUpdateToken()),
                );
              })
            ],
          )
      ),
    );
  }

  Future<void> verifyPhone(phoneNo)async{
    final PhoneVerificationCompleted verified = (AuthCredential authResule){

    };

    final PhoneVerificationFailed verificationFailed = (FirebaseAuthException authException){
      print('${authException.message}');
    };

    final PhoneCodeSent smsSend = (String verId, [int forceResend]){
      this.veridicationId = verId;
    };

    final PhoneCodeAutoRetrievalTimeout autoTmeout = (String verId){
      this.veridicationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationFailed,
        codeSent: null,
        codeAutoRetrievalTimeout: null);
  }
}
