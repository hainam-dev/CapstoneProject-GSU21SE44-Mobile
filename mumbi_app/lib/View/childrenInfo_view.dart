import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/ViewModel/child_viewmodel.dart';
import 'package:mumbi_app/Widget/calendarBirthday.dart';
import 'package:mumbi_app/Widget/calendarCalculate.dart';
import 'package:mumbi_app/Widget/customBottomButton.dart';
import 'package:mumbi_app/Widget/customDialog.dart';
import 'package:mumbi_app/Widget/customInputText.dart';
import 'package:mumbi_app/Widget/customStatusDropdown.dart';
import 'package:mumbi_app/Widget/customText.dart';
import 'package:mumbi_app/Widget/imagePicker.dart';

import 'myFamily_view.dart';

class ChildrenInfo extends StatefulWidget {
  final childModel;
  final action;
  ChildrenInfo(this.childModel, this.action);

  @override
  _ChildrenInfoState createState() => _ChildrenInfoState();
}

class _ChildrenInfoState extends State<ChildrenInfo> {
  final formKey = GlobalKey<FormState>();
  String selectedStatusValue;
  String defaultImage = chooseImage;
  String update = "Update";
  String born = "Bé chào đời";
  String notBorn = "Thai nhi";
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
          color: WHITE_COLOR,
        ),
        actions: <Widget>[
          if(widget.action == update)
            PopupMenuButton<String>(
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {'Xóa thành viên'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            )
        ],
      ),
      body: Container(
        height: SizeConfig.blockSizeVertical * 100,
        width: SizeConfig.blockSizeHorizontal * 100,
        child: Column(
          children: [
            PickerImage(widget.action == update ? widget.childModel['image'] : defaultImage),
            new Container(
              height: SizeConfig.blockSizeVertical * 55,
              width: SizeConfig.blockSizeHorizontal * 90,
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    const SizedBox(height: 5),
                    CustomInputText('Họ & tên (*)', widget.action == update ? widget.childModel['fullName'] : "", function: (value){
                      setState(() {
                        if(widget.action == update){
                          widget.childModel['fullName'] = value;
                        }else{

                        }
                      });
                    },),
                    const SizedBox(height: 12),
                    CustomInputText('Tên ở nhà', widget.action == update ? widget.childModel['nickname'] : ""),
                    const SizedBox(height: 12),
                    new CustomStatusDropdown(
                      'Trạng thái (*)',
                      itemsStatus,
                      widget.action == update ? getStatus(widget.childModel['isBorn']) : null,
                      function: (value) {
                        setState(
                          () {
                            selectedStatusValue = value;
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    (selectedStatusValue.toString() == born)
                        ? CalendarBirthday('Ngày sinh',widget.action == update ? widget.childModel['birthDay'] : "")
                        : (selectedStatusValue.toString() == notBorn)
                            ? CalendarCalculate()
                            : CalendarBirthday('Ngày sinh',widget.action == update ? widget.childModel['birthDay'] : ""),
                    const SizedBox(height: 12),
                    new CustomStatusDropdown(
                      'Giới tính (*)',
                      itemsGender,
                      widget.action == update ? widget.childModel['gender'] : null,
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
        saveFunction: () async {
          if(formKey.currentState.validate()){
            bool result = false;
            if(widget.action == update){
              result = await ChildViewModel().updateChildInfo(widget.childModel);
            }
          }
        }
      ),
    );
  }

  String getStatus(bool value){
    if(value){
      return born;
    }else{
      return notBorn;
    }
  }

  Future<void> handleClick(String value) async {
    switch (value) {
      case 'Xóa thành viên':
        bool result = false;
        result = await ChildViewModel().deleteChild(widget.childModel['id']);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyFamily()));
        showResult(context,result);
        break;
    }
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
      value: 'Bé chào đời',
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
              text: 'Bé chào đời',
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
    DropdownMenuItem(
      value: 'Chưa biết',
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Icon(
            Icons.contact_support_outlined,color: BLACK_COLOR,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: new CustomText(
              text: 'Chưa biết',
            ),
          ),
        ],
      ),
    ),
  ];
}
