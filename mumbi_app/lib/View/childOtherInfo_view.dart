import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mumbi_app/Constant/Variable.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Constant/common_message.dart';
import 'package:mumbi_app/Global/CurrentMember.dart';
import 'package:mumbi_app/Utils/datetime_convert.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/ViewModel/child_viewmodel.dart';
import 'package:mumbi_app/Widget/customBottomButton.dart';
import 'package:mumbi_app/Widget/customInputNumber.dart';
import 'package:scoped_model/scoped_model.dart';

class ChildInfoUpdate extends StatefulWidget {
  _ChildInfoUpdateState createState() => _ChildInfoUpdateState();
}

class _ChildInfoUpdateState extends State<ChildInfoUpdate> {
  final formKey = GlobalKey<FormState>();
  ChildViewModel childViewModel;

  @override
  void initState() {
    super.initState();
    childViewModel = ChildViewModel.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: childViewModel,
      child: ScopedModelDescendant(builder: (BuildContext context, Widget child, ChildViewModel model) {
        return Scaffold(
          extendBody: true,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.keyboard_backspace),
              onPressed: () => {
                Navigator.pop(context)
              },
            ),
            title: Text("Ngày ${DateTimeConvert.getCurrentDay()}"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DisabledTextField(
                      CurrentMember.pregnancyFlag == true ? 'Tuần thai' : "Tuần tuổi",
                      CurrentMember.pregnancyFlag == true
                          ? "Tuần ${DateTimeConvert.pregnancyWeek(model.childModel.estimatedBornDate)}"
                          : "Tuần ${DateTimeConvert.calculateChildWeekAge(model.childModel.birthday)}",
                    ),
                    if(CurrentMember.pregnancyFlag == true)
                      PregnancyInfo(),
                    if(CurrentMember.pregnancyFlag == false)
                      ChildInfo(),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: CustomBottomButton(
              titleCancel: 'Hủy',
              titleSave: 'Lưu thông tin',
              cancelFunction: () => {Navigator.pop(context)},
              saveFunction: () async {
                if (formKey.currentState.validate()) {

                }
              }),
        );
      },),
    );
  }

  Widget PregnancyInfo(){
    return Column(
      children: [
          DigitalNumber(
            'Cân nặng của mẹ (kg)',
            "",
          ),
          DigitalNumber(
            'Cân nặng thai nhi (kg)',
            "",
          ),
          DigitalNumber(
            'Đường kính vòng đầu (cm)',
            "",
          ),
          DigitalNumber(
            'Nhịp tim thai (lần/phút)',
            "",
          ),
          DigitalNumber(
            'Chiều dài xương đùi (cm)',
            "",
          ),
          DigitalNumber(
            'Chiều dài đầu (cm)',
            "",
          ),
      ],
    );
  }

  Widget ChildInfo(){
    return Column(
      children: [
          DigitalNumber(
              CHILD_WEIGHT_FIELD,
            "",
          ),
          DigitalNumber(
            CHILD_HEIGHT_FIELD,
            "",
          ),
          DigitalNumber(
            CHILD_HEAD_CIRCUMFERENCE_FIELD,
            "",
          ),
          DigitalNumber(
            CHILD_SLEEP_TIME_FIELD,
            "",
          ),
          DigitalNumber(
            CHILD_MILK_FIELD,
            "",
          ),
      ],
    );
  }

  Widget DisabledTextField(String name,String value) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1,vertical: 6),
        child: TextFormField(
          enabled: false,
          initialValue: value,
          style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w100),
          decoration: InputDecoration(
            labelStyle: TextStyle(color: PINK_COLOR),
            labelText: name,
            hintStyle: TextStyle(color: PINK_COLOR),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      );

  Widget DigitalNumber(String title, String value, {Function onType}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1,vertical: 6),
        child: TextFormField(
        initialValue: value,
        decoration: InputDecoration(
            labelStyle: TextStyle(color: PINK_COLOR),
            labelText: title,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: PINK_COLOR),
            ),
          ),
          validator: (value) {
              if (value.isEmpty) {
                return null;
              } else if (title == CHILD_WEIGHT_FIELD && !isBetween(num.parse(value),1,50)){
                return CHILD_WEIGHT_VALIDATION_MESSAGE;
              } else if (title == CHILD_HEIGHT_FIELD && !isBetween(num.parse(value),25,130)){
                return CHILD_HEIGHT_VALIDATION_MESSAGE;
              } else if (title == CHILD_HEAD_CIRCUMFERENCE_FIELD && !isBetween(num.parse(value),25,60)){
                return CHILD_HEAD_CIRCUMFERENCE_VALIDATION_MESSAGE;
              } else if (title == CHILD_SLEEP_TIME_FIELD && !isBetween(num.parse(value),7,16)){
                return CHILD_SLEEP_TIME_VALIDATION_MESSAGE;
              } else if (title == CHILD_MILK_FIELD && !isBetween(num.parse(value),25,130)){
                return CHILD_MILK_VALIDATION_MESSAGE;
              } else {
                return null;
              }
          },
          onChanged: onType,
          keyboardType:
          TextInputType.numberWithOptions(decimal: true, signed: false),
          inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
              TextInputFormatter.withFunction((oldValue, newValue) {
                try {
                  final text = newValue.text;
                  if (text.isNotEmpty) double.parse(text);
                  return newValue;
                } catch (e) {}
                return oldValue;
              }),
          ],
        ),
      );

  bool isBetween(num value, num min, num max) {
    if (value <= max && value >= min) {
      return true;
    }
    return false;
  }

}

