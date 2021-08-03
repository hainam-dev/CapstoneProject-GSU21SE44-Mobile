import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Global/CurrentMember.dart';
import 'package:mumbi_app/Utils/datetime_convert.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/Widget/customBottomButton.dart';
import 'package:mumbi_app/Widget/customInputNumber.dart';

class ChildInfoUpdate extends StatefulWidget {
  final model;
  ChildInfoUpdate(this.model) ;

  @override
  _ChildInfoUpdateState createState() => _ChildInfoUpdateState();
}

class _ChildInfoUpdateState extends State<ChildInfoUpdate> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CurrentMember.pregnancyFlag == true ? 'Cập nhật thông tin thai kì' : 'Cập nhật thông tin bé'),
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: () => {
            Navigator.pop(context)
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                DisabledTextField(
                  CurrentMember.pregnancyFlag == true ? 'Tuần thai' : "Tuần tuổi",
                  CurrentMember.pregnancyFlag == true
                      ? "Tuần ${DateTimeConvert.pregnancyWeek(widget.model.estimatedBornDate)}"
                      : "Tuần ${DateTimeConvert.calculateChildWeekAge(widget.model.birthday)}",
                ),
                if(CurrentMember.pregnancyFlag == true)
                DigitalNumber(
                  'Cân nặng của mẹ (kg)',
                  "",
                ),
                if(CurrentMember.pregnancyFlag == true)
                DigitalNumber(
                  'Cân nặng thai nhi (kg)',
                  "",
                ),
                if(CurrentMember.pregnancyFlag == true)
                DigitalNumber(
                  'Đường kính vòng đầu (cm)',
                  "",
                ),
                if(CurrentMember.pregnancyFlag == true)
                DigitalNumber(
                  'Nhịp tim thai (lần/phút)',
                  "",
                ),
                if(CurrentMember.pregnancyFlag == true)
                DigitalNumber(
                  'Chiều dài xương đùi (cm)',
                  "",
                ),
                if(CurrentMember.pregnancyFlag == true)
                DigitalNumber(
                  'Chiều dài đầu (cm)',
                  "",
                ),

                if(CurrentMember.pregnancyFlag == false)
                DigitalNumber(
                  'Cân nặng (kg)',
                  "",
                ),
                if(CurrentMember.pregnancyFlag == false)
                DigitalNumber(
                  'Chiều cao (cm)',
                  "",
                ),
                if(CurrentMember.pregnancyFlag == false)
                DigitalNumber(
                  'Đường kính vòng đầu (cm)',
                  "",
                ),
                if(CurrentMember.pregnancyFlag == false)
                DigitalNumber(
                  'Số giờ ngủ của bé',
                  "",
                ),
                if(CurrentMember.pregnancyFlag == false)
                DigitalNumber(
                  'Số lượng sữa bé uống',
                  "",
                ),
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
  }

  Widget DisabledTextField(String name,String value) => Container(
    height: SizeConfig.blockSizeVertical * 7,
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
          borderSide: BorderSide(
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: PINK_COLOR, width: 1.0),
        ),
      ),
    ),
  );

  Widget DigitalNumber(String title, String value, {Function onClick}) => Container(
    height: SizeConfig.blockSizeVertical * 7,
    child: TextFormField(
      initialValue: value,
      decoration: InputDecoration(
        labelStyle: TextStyle(color: PINK_COLOR),
        labelText: title,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: PINK_COLOR, width: 1.0),
        ),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return null;
        } else {
          return null;
        }
      },
      onChanged: onClick,
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

  bool isBetween(int value, int min, int max) {
    if (value <= max && value >= min) {
      return true;
    }
    return false;
  }

}

