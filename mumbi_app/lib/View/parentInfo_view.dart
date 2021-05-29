import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/Widget/calendarBirthday.dart';
import 'package:mumbi_app/Widget/customBottomButton.dart';
import 'package:mumbi_app/Widget/customInputNumber.dart';
import 'package:mumbi_app/Widget/customInputText.dart';
import 'package:mumbi_app/Widget/customText.dart';
import 'package:mumbi_app/Widget/imagePicker.dart';

class ParentInfo extends StatefulWidget {
  final appbarTitle;

  ParentInfo(this.appbarTitle);

  @override
  _ParentInfoState createState() => _ParentInfoState(this.appbarTitle);
}

class _ParentInfoState extends State<ParentInfo> {
  final formKey = GlobalKey<FormState>();
  final appbarTitle;

  _ParentInfoState(this.appbarTitle);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: SizeConfig.blockSizeVertical * 6,
        title: CustomText(
          text: '$appbarTitle',
          size: 20.0,
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        height: SizeConfig.blockSizeVertical * 100,
        width: SizeConfig.blockSizeHorizontal * 100,
        child: Column(
          children: [
            PickerImage(),
            new Container(
              height: SizeConfig.blockSizeVertical * 65,
              width: SizeConfig.blockSizeHorizontal * 90,
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    CustomInputText('Họ & tên (*)'),
                    const SizedBox(height: 12),
                    CalendarBirthday('Ngày sinh'),
                    const SizedBox(height: 12),
                    CustomInputNumber('Số điện thoại'),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: _buildBloodGroup(
                              'Nhóm máu', 'Nhóm máu', ['A', 'B', 'O', 'AB']),
                          flex: 2,
                        ),
                        const SizedBox(
                          width: 17,
                        ),
                        Flexible(
                          child: _buildBloodGroup('Hệ máu (Rh)', 'Hệ máu (Rh)',
                              ['RH(D)+', 'RH(D)-']),
                          flex: 2,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 166,
                    ),
                    CustomBottomButton()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBloodGroup(
          String labelText, String hinText, List<String> items) =>
      Container(
        height: SizeConfig.blockSizeVertical * 7,
        width: SizeConfig.blockSizeHorizontal * 45,
        child: new DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelStyle: TextStyle(color: PINK_COLOR),
            labelText: labelText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 1,
              ),
            ),
          ),
          hint: Text(
            hinText,
            style: TextStyle(color: PINK_COLOR),
          ),
          items: items.map((String value) {
            return new DropdownMenuItem<String>(
              value: value,
              child: new Text(value),
            );
          }).toList(),
          onChanged: (_) {},
        ),
      );
}
