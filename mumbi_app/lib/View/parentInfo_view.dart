import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Model/mom_model.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/ViewModel/parent_viewmodel.dart';
import 'package:mumbi_app/Widget/calendarBirthday.dart';
import 'package:mumbi_app/Widget/customBottomButton.dart';
import 'package:mumbi_app/Widget/customInputNumber.dart';
import 'package:mumbi_app/Widget/customInputText.dart';
import 'package:mumbi_app/Widget/customText.dart';
import 'package:mumbi_app/Widget/imagePicker.dart';
import 'package:scoped_model/scoped_model.dart';

class ParentInfo extends StatefulWidget {
  final appbarTitle;
  final model;
  ParentInfo(this.appbarTitle, this.model);

  @override
  _ParentInfoState createState() => _ParentInfoState(this.appbarTitle);
}

class _ParentInfoState extends State<ParentInfo> {
  final formKey = GlobalKey<FormState>();
  String accountID;

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
          color: WHITE_COLOR,
        ),
      ),
      backgroundColor: Colors.white,
      body: widget.model == null ? Center(child: CircularProgressIndicator()) : Container(
              height: SizeConfig.blockSizeVertical * 100,
              width: SizeConfig.blockSizeHorizontal * 100,
              child: Column(
                children: [
                  PickerImage(widget.model.image != null ? widget.model.image : ""),
                  new Container(
                    height: SizeConfig.blockSizeVertical * 55,
                    width: SizeConfig.blockSizeHorizontal * 90,
                    child: Form(
                      key: formKey,
                      child: ListView(
                        children: [
                          CustomInputText('Họ & tên (*)', widget.model.fullName != null ? widget.model.fullName : ""),
                          const SizedBox(height: 12),
                          CalendarBirthday('Ngày sinh', widget.model.birthday != null ? widget.model.birthday : ""),
                          const SizedBox(height: 12),
                          CustomInputNumber('Số điện thoại', widget.model.phoneNumber != null ? widget.model.phoneNumber : ""),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                child: _buildBloodGroup(
                                    'Nhóm máu', 'Nhóm máu',
                                    ['A', 'B', 'O', 'AB'],widget.model.bloodGroup),
                                flex: 2,
                              ),
                              const SizedBox(
                                width: 17,
                              ),
                              Flexible(
                                child: _buildBloodGroup(
                                    'Hệ máu (Rh)', 'Hệ máu (Rh)',
                                    ['RH(D)+', 'RH(D)-'],widget.model.rhBloodGroup),
                                flex: 2,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: CustomBottomButton(
        titleCancel: 'Hủy',
        titleSave: 'Lưu thông tin',
        cancelFunction: () => {Navigator.pop(context)},
        saveFunction: () async {
        },
      ),
    );
  }

  Widget _buildBloodGroup(String labelText, String hinText,
      List<String> items,String selectedValue) =>
      Container(
        height: SizeConfig.blockSizeVertical * 7,
        width: SizeConfig.blockSizeHorizontal * 45,
        child: new DropdownButtonFormField<String>(
          value: selectedValue,
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
          onChanged: (value) {
            setState(() {
              selectedValue = value;
            });
          },
        ),
      );
}
