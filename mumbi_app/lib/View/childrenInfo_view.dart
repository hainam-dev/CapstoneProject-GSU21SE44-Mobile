import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/Widget/calendarBirthday.dart';
import 'package:mumbi_app/Widget/calendarCalculate.dart';
import 'package:mumbi_app/Widget/customBottomButton.dart';
import 'package:mumbi_app/Widget/customInputText.dart';
import 'package:mumbi_app/Widget/customStatusDropdown.dart';
import 'package:mumbi_app/Widget/customText.dart';
import 'package:mumbi_app/Widget/imagePicker.dart';

class ChildrenInfo extends StatefulWidget {
  @override
  _ChildrenInfoState createState() => _ChildrenInfoState();
}

class _ChildrenInfoState extends State<ChildrenInfo> {
  final formKey = GlobalKey<FormState>();
  String selectedValue;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: SizeConfig.blockSizeVertical * 6,
        title: CustomText(
          text: 'Thêm bé/thai kì',
          size: 20.0,
        ),
      ),
      body: Container(
        height: SizeConfig.blockSizeVertical * 100,
        width: SizeConfig.blockSizeHorizontal * 100,
        child: Column(
          children: [
            PickerImage(),
            new Container(
              height: SizeConfig.blockSizeVertical * 55,
              width: SizeConfig.blockSizeHorizontal * 90,
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    const SizedBox(height: 5),
                    CustomInputText('Họ & tên (*)'),
                    const SizedBox(height: 12),
                    CustomInputText('Tên ở nhà'),
                    const SizedBox(height: 12),
                    new CustomStatusDropdown(
                      'Trạng thái (*)',
                      itemsStatus,
                      function: (value) {
                        setState(
                          () {
                            selectedValue = value;
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    (selectedValue.toString() == "Bé đã sinh")
                        ? CalendarBirthday('Ngày sinh')
                        : (selectedValue.toString() == "Thai nhi")
                            ? CalendarCalculate()
                            : CalendarBirthday('Ngày sinh'),
                    const SizedBox(height: 12),
                    new CustomStatusDropdown(
                      'Giới tính (*)',
                      itemsGender,
                      function: (value) {
                        setState(
                          () {},
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomButton(titleCancel: 'Hủy',titleSave: 'Lưu thông tin',
        cancelFunction: () => {Navigator.pop(context)},
        saveFunction: () => {print('Clicked save information childrend')},
      ),
    );
  }

  final List<DropdownMenuItem<String>> itemsStatus = [
    DropdownMenuItem(
      value: 'Thai nhi',
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Image.asset(
            iconChild,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: new CustomText(
              text: 'Thai nhi',
            ),
          ),
        ],
      ),
    ),
    DropdownMenuItem(
      value: 'Bé đã sinh',
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Image.asset(
            iconChild,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: new CustomText(
              text: 'Bé đã sinh',
            ),
          ),
        ],
      ),
    ),
  ];

  final List<DropdownMenuItem<String>> itemsGender = [
    DropdownMenuItem(
      value: 'Bé trai',
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Image.asset(
            iconBoy,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: new CustomText(
              text: 'Bé trai',
            ),
          ),
        ],
      ),
    ),
    DropdownMenuItem(
      value: 'Bé gái',
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Image.asset(
            iconGirl,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: new CustomText(
              text: 'Bé gái',
            ),
          ),
        ],
      ),
    ),
  ];
}
