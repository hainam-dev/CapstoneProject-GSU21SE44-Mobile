import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Model/child_model.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/Utils/upload_image.dart';
import 'package:mumbi_app/ViewModel/child_viewmodel.dart';
import 'package:mumbi_app/Widget/calendarBirthday.dart';
import 'package:mumbi_app/Widget/calendarCalculate.dart';
import 'package:mumbi_app/Widget/customBottomButton.dart';
import 'package:mumbi_app/Widget/customDialog.dart';
import 'package:mumbi_app/Widget/customInputNumber.dart';
import 'package:mumbi_app/Widget/customInputText.dart';
import 'package:mumbi_app/Widget/customStatusDropdown.dart';
import 'package:mumbi_app/Widget/customText.dart';
import 'package:mumbi_app/Widget/imagePicker.dart';

class ChildrenInfo extends StatefulWidget {
  final model;
  final action;

  ChildrenInfo(this.model, this.action);

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
  ChildModel childModel;

  @override
  void initState() {
    if (widget.action != update) {
      childModel = ChildModel();
    }
    super.initState();
  }

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
          if (widget.action == update)
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
            PickerImage(
                widget.action == update ? widget.model.imageURL : defaultImage),
            new Container(
              height: SizeConfig.blockSizeVertical * 58,
              width: SizeConfig.blockSizeHorizontal * 93,
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    SizedBox(height: SizeConfig.blockSizeVertical * 1),
                    CustomInputText(
                      'Họ & tên (*)',
                      widget.action == update ? widget.model.fullName : "",
                      function: (value) {
                        setState(() {
                          if (widget.action == update) {
                            widget.model.fullName = value;
                          } else {
                            childModel.fullName = value;
                          }
                        });
                      },
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 1),
                    CustomInputText(
                      'Tên ở nhà',
                      widget.action == update ? widget.model.nickname : "",
                      function: (value) {
                        setState(() {
                          if (widget.action == update) {
                            widget.model.nickname = value;
                          } else {
                            childModel.nickname = value;
                          }
                        });
                      },
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 1.2),
                    CustomStatusDropdown(
                      'Trạng thái (*)',
                      itemsStatus,
                      widget.action == update
                          ? showStatus(widget.model.bornFlag)
                          : null,
                      function: (value) {
                        setState(
                          () {
                            selectedStatusValue = value;
                            if (widget.action == update) {
                              widget.model.bornFlag =
                                  (value == born ? true : false);
                            } else {
                              childModel.bornFlag =
                                  (value == born ? true : false);
                            }
                          },
                        );
                      },
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 1.5),
                    if (widget.action == update &&
                            widget.model.bornFlag == true ||
                        selectedStatusValue.toString() == born)
                      CalendarBirthday(
                        'Ngày sinh',
                        widget.action == update ? widget.model.birthday : "",
                        function: (value) {
                          if (value.isEmpty) {
                            return "Vui lòng chọn ngày sinh cho bé";
                          } else {
                            setState(() {
                              if (widget.action == update) {
                                widget.model.birthday = value;
                              } else {
                                childModel.birthday = value;
                              }
                            });
                            return null;
                          }
                        },
                      ),
                    if (widget.action == update &&
                            widget.model.bornFlag == false ||
                        selectedStatusValue.toString() == notBorn)
                      CalendarCalculate(
                        widget.action == update
                            ? widget.model.estimatedBornDate
                            : "",
                        function: (value) {
                          if (value.isEmpty) {
                            return "Vui lòng chọn ngày dự sinh cho bé";
                          } else {
                            setState(() {
                              if (widget.action == update) {
                                widget.model.estimatedBornDate = value;
                              } else {
                                childModel.estimatedBornDate = value;
                              }
                            });
                            return null;
                          }
                        },
                      ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 1.5),
                    CustomStatusDropdown(
                      'Giới tính (*)',
                      itemsGender,
                      widget.action == update ? showGender(widget.model.gender) : null,
                      function: (value) {
                        setState(
                          () {
                            if (widget.action == update) {
<<<<<<< HEAD
                              widget.model.gender = value;
                            } else {
                              childModel.gender = value;
=======
                              widget.model.gender = getGender(value);
                            }else{
                              childModel.gender = getGender(value);
>>>>>>> origin/Implement/FetchData/DuyPH_TheAdventureContinues
                            }
                          },
                        );
                      },
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 1.5),
                    if (widget.action == update &&
                            widget.model.bornFlag == true ||
                        selectedStatusValue.toString() == born)
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: _buildBloodGroup(
                                'Nhóm máu',
                                'Nhóm máu',
                                ['A', 'B', 'O', 'AB'],
                                widget.action == update
                                    ? widget.model.bloodGroup
                                    : null, (value) {
                              setState(() {
                                if (widget.action == update) {
                                  widget.model.bloodGroup = value;
                                } else {
                                  childModel.bloodGroup = value;
                                }
                              });
                            }),
                            flex: 2,
                          ),
                          const SizedBox(
                            width: 17,
                          ),
                          Flexible(
                            child: _buildBloodGroup(
                                'Hệ máu (Rh)',
                                'Hệ máu (Rh)',
                                ['RH(D)+', 'RH(D)-'],
                                widget.action == update
                                    ? widget.model.rhBloodGroup
                                    : null, (value) {
                              setState(() {
                                if (widget.action == update) {
                                  widget.model.rhBloodGroup = value;
                                } else {
                                  childModel.rhBloodGroup = value;
                                }
                              });
                            }),
                            flex: 2,
                          ),
                        ],
                      ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 1.7),
                    if (widget.action == update &&
                            widget.model.bornFlag == true ||
                        selectedStatusValue.toString() == born)
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: CustomInputNumber(
                                'Xoáy đầu',
                                widget.action == update
                                    ? widget.model.headVortex.toString()
                                    : "", function: (value) {
                              setState(() {
                                if (widget.action == update) {
                                  if (value == "") {
                                    widget.model.headVortex = 0;
                                  } else {
                                    widget.model.headVortex =
                                        num.parse(value.toString());
                                  }
                                } else {
                                  if (value == "") {
                                    childModel.headVortex = 0;
                                  } else {
                                    childModel.headVortex =
                                        num.parse(value.toString());
                                  }
                                }
                              });
                            }),
                            flex: 2,
                          ),
                          const SizedBox(
                            width: 17,
                          ),
                          Flexible(
                            child: CustomInputNumber(
                                'Số vân tay',
                                widget.action == update
                                    ? widget.model.fingertips.toString()
                                    : "", function: (value) {
                              setState(() {
                                if (widget.action == update) {
                                  if (value == "") {
                                    widget.model.fingertips = 0;
                                  } else {
                                    widget.model.fingertips =
                                        num.parse(value.toString());
                                  }
                                } else {
                                  if (value == "") {
                                    childModel.fingertips = 0;
                                  } else {
                                    childModel.fingertips =
                                        num.parse(value.toString());
                                  }
                                }
                              });
                            }),
                            flex: 2,
                          ),
                        ],
                      ),
                    Padding(
                        padding: EdgeInsets.only(
                            bottom:
                                MediaQuery.of(context).viewInsets.bottom / 2)),
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
            String url = await uploadImageToFirebase(
                widget.action == update ? widget.model.id : childModel.id);
            if (url != null) {
              if (widget.action == update) {
                widget.model.imageURL = url;
              } else {
                childModel.imageURL = url;
              }
            }
            if (formKey.currentState.validate()) {
              bool result = false;
              if (widget.action == update) {
                result = await ChildViewModel().updateChildInfo(widget.model);
              } else {
                if (childModel.fingertips == null) childModel.fingertips = 0;
                if (childModel.headVortex == null) childModel.headVortex = 0;
                result = await ChildViewModel().addChild(childModel);
                if (result == true) {
                  Navigator.pop(context);
                }
              }
              showResult(context, result);
            }
          }),
    );
  }

  String showStatus(bool value) {
    if (value) {
      return born;
    } else {
      return notBorn;
    }
  }

  Future<void> handleClick(String value) async {
    switch (value) {
      case 'Xóa thành viên':
        bool result = false;
        result = await ChildViewModel().deleteChild(widget.model.id);
        Navigator.pop(context);
        showResult(context, result);
        break;
    }
  }

  String showGender(int num){
    switch (num){
      case 0: return "Chưa biết"; break;
      case 1: return "Bé trai"; break;
      case 2: return "Bé gái"; break;
      default: return "";
    }
  }

  int getGender(String gender){
    switch (gender){
      case "Chưa biết": return 0; break;
      case "Bé trai": return 1; break;
      case "Bé gái": return 2; break;
      default: return null;
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
            Icons.contact_support_outlined,
            color: BLACK_COLOR,
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

  Widget _buildBloodGroup(String labelText, String hinText, List<String> items,
          String selectedValue, Function function) =>
      Container(
        height: SizeConfig.blockSizeVertical * 7,
        width: SizeConfig.blockSizeHorizontal * 45,
        child: DropdownButtonFormField<String>(
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
          onChanged: function,
        ),
      );
}
