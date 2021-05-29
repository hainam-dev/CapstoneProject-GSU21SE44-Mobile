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
              height: SizeConfig.blockSizeVertical * 65,
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
                      'Thai nhi',
                      'Bé đã sinh',
                      iconChild,
                      iconChild,
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
                      'Bé trai',
                      'Bé gái',
                      iconBoy,
                      iconGirl,
                      function: (value) {
                        setState(
                          () {},
                        );
                      },
                    ),
                    const SizedBox(height: 88),
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
}
