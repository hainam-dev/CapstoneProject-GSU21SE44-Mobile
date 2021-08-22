import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mumbi_app/Constant/textStyle.dart';
import 'package:mumbi_app/Repository/vaccination_respository.dart';
import 'package:mumbi_app/View/injectionSchedule.dart';
import 'package:mumbi_app/View/injectionUpdateToken_view.dart';
import 'package:mumbi_app/Widget/customComponents.dart';

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
  PhoneNumber number = PhoneNumber(isoCode: 'VN');

  void onNextBtn() {
    if (formKey.currentState.validate()) {
      //0902741611
      //Navigator.push(context, MaterialPageRoute(builder: (context) => InjectionUpdateToken(phoneNo: phoneNoController.text)), );
      showCustomProgressDialog(
          context,
          "Vui lòng đợi",
          widget.isRecover
              ? VaccinationRespository.getOTPRecoveryPass(
                  phoneNoController.text)
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.isRecover ? "Quên mật khẩu" : "Lịch Tiêm chủng"),
          leading: backButton(context, InjectionSchedule())),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            createTextTitle(widget.isRecover
                ? "Vui lòng nhập số điện thoại đã đăng ký"
                : "Vui lòng nhập số điện thoại đã đăng ký để xem thông tin chi tiết lịch tiêm chủng của bé."),
            Container(
              padding: EdgeInsets.only(top: 16, bottom: 16),
              child: Form(
                key: formKey,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InternationalPhoneNumberInput(
                        hintText: "Số điện thoại",
                        onInputChanged: (PhoneNumber number) {
                          print(number.phoneNumber);
                        },
                        onInputValidated: (bool value) {
                          print(value);
                        },
                        selectorConfig: SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        ),
                        ignoreBlank: false,
                        autoValidateMode: AutovalidateMode.disabled,
                        selectorTextStyle: TextStyle(color: Colors.black),
                        initialValue: number,
                        textFieldController: phoneNoController,
                        formatInput: false,
                        keyboardType: TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        inputBorder: OutlineInputBorder(),
                        onSaved: (PhoneNumber number) {
                          print('On Saved: $number');
                        },
                        errorMessage: "Vui lòng nhập số điện thoại của bạn",
                      ),
                    ],
                  ),
                ),
              ),
            ),
            createButtonConfirm("Tiếp tục", onNextBtn),
          ],
        ),
      )),
    );
  }
}
