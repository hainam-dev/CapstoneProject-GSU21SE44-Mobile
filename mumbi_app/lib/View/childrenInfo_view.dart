import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mumbi_app/Constant/Variable.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Constant/common_message.dart';
import 'package:mumbi_app/Global/CurrentMember.dart';
import 'package:mumbi_app/Model/child_model.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/Utils/upload_image.dart';
import 'package:mumbi_app/ViewModel/child_viewmodel.dart';
import 'package:mumbi_app/Widget/calendarBirthday.dart';
import 'package:mumbi_app/Widget/calendarCalculate.dart';
import 'package:mumbi_app/Widget/customBottomButton.dart';
import 'package:mumbi_app/Widget/customConfirmDialog.dart';
import 'package:mumbi_app/Widget/customDialog.dart';
import 'package:mumbi_app/Widget/customInputNumber.dart';
import 'package:mumbi_app/Widget/customInputText.dart';
import 'package:mumbi_app/Widget/customProgressDialog.dart';
import 'package:mumbi_app/Widget/customStatusDropdown.dart';
import 'package:mumbi_app/Widget/customText.dart';
import 'package:mumbi_app/Widget/imagePicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChildrenInfo extends StatefulWidget {
  final model;
  final action;
  final entry;

  ChildrenInfo(this.model, this.action, this.entry);

  @override
  _ChildrenInfoState createState() => _ChildrenInfoState();
}

class _ChildrenInfoState extends State<ChildrenInfo> {
  final formKey = GlobalKey<FormState>();
  String selectedStatusValue;
  String pickImage = chooseImage;
  String born = "Bé chào đời";
  String notBorn = "Thai nhi";
  ChildModel childModel;

  @override
  void initState() {
    if (widget.action == CREATE_STATE) {
      childModel = ChildModel();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: CustomText(
          text: widget.entry == CHILD_ENTRY
              ? CHILD_APP_BAR_TITLE
              : PREGNANCY_APP_BAR_TITLE,
          size: 20.0,
          color: WHITE_COLOR,
        ),
        actions: <Widget>[
          if (widget.action == UPDATE_STATE) MoreButton(),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                PickerImage(widget.action == UPDATE_STATE
                    ? widget.model.imageURL
                    : pickImage),
                CustomInputText(
                  FULL_NAME_FIELD,
                  widget.action == UPDATE_STATE ? widget.model.fullName : "",
                  function: (value) {
                    setState(() {
                      if (widget.action == UPDATE_STATE) {
                        widget.model.fullName = value;
                      } else {
                        childModel.fullName = value;
                      }
                    });
                  },
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: CustomInputText(
                        HOME_NAME_FIELD,
                        widget.action == UPDATE_STATE ? widget.model.nickname : "",
                        function: (value) {
                          setState(() {
                            if (widget.action == UPDATE_STATE) {
                              widget.model.nickname = value;
                            } else {
                              childModel.nickname = value;
                            }
                          });
                        },
                      ),
                      flex: 2,
                    ),
                    if (widget.entry == CHILD_ENTRY)
                    const SizedBox(
                      width: 17,
                    ),
                    if (widget.entry == CHILD_ENTRY)
                    Flexible(
                      child: CustomStatusDropdown(
                        GENDER_FIELD,
                        itemsGender,
                        widget.action == UPDATE_STATE
                            ? showGender(widget.model.gender)
                            : null,
                        function: (value) {
                          setState(
                                () {
                              if (widget.action == UPDATE_STATE) {
                                widget.model.gender = getGender(value);
                              } else {
                                childModel.gender = getGender(value);
                              }
                            },
                          );
                        },
                      ),
                      flex: 2,
                    ),
                  ],
                ),
                if (widget.entry == PREGNANCY_ENTRY)
                  CalendarCalculate(
                    widget.action == UPDATE_STATE
                        ? widget.model.estimatedBornDate
                        : "",
                    function: (value) {
                      if (value.isEmpty) {
                        return "Vui lòng chọn ngày dự sinh cho bé";
                      } else {
                        setState(() {
                          if (widget.action == UPDATE_STATE) {
                            widget.model.estimatedBornDate = value;
                          } else {
                            childModel.estimatedBornDate = value;
                          }
                        });
                        return null;
                      }
                    },
                  ),
                if (widget.entry == CHILD_ENTRY)
                  CalendarBirthday(
                    CHILD_BIRTHDAY_FIELD,
                    widget.action == UPDATE_STATE ? widget.model.birthday : "",
                    function: (value) {
                      if (value.isEmpty) {
                        return "Vui lòng chọn ngày sinh cho bé";
                      } else {
                        setState(() {
                          if (widget.action == UPDATE_STATE) {
                            widget.model.birthday = value;
                          } else {
                            childModel.birthday = value;
                          }
                        });
                        return null;
                      }
                    },
                  ),
                if (widget.entry == CHILD_ENTRY)
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: _buildBloodGroup(
                            'Nhóm máu',
                            'Nhóm máu',
                            ['A', 'B', 'O', 'AB'],
                            widget.action == UPDATE_STATE
                                ? widget.model.bloodGroup
                                : null, (value) {
                          setState(() {
                            if (widget.action == UPDATE_STATE) {
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
                            widget.action == UPDATE_STATE
                                ? widget.model.rhBloodGroup
                                : null, (value) {
                          setState(() {
                            if (widget.action == UPDATE_STATE) {
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
                if (widget.entry == CHILD_ENTRY)
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: CustomInputNumber(
                            'Xoáy đầu',
                            widget.action == UPDATE_STATE
                                ? widget.model.headVortex.toString()
                                : "", function: (value) {
                          setState(() {
                            if (widget.action == UPDATE_STATE) {
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
                            widget.action == UPDATE_STATE
                                ? widget.model.fingertips.toString()
                                : "", function: (value) {
                          setState(() {
                            if (widget.action == UPDATE_STATE) {
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
                CustomBottomButton(
                    titleCancel: 'Hủy',
                    titleSave: widget.action == UPDATE_STATE
                        ? 'Cập nhật thông tin'
                        : "Lưu thông tin",
                    cancelFunction: () => {Navigator.pop(context)},
                    saveFunction: () async {
                      if (formKey.currentState.validate()) {
                        showProgressDialogue(context);
                        if(widget.model.bornFlag == false && widget.entry == CHILD_ENTRY){
                          widget.model.bornFlag = true;
                          CurrentMember.pregnancyFlag = false;
                          CurrentMember.pregnancyID = null;
                        }
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        String fileContentBase64 = prefs.getString('UserImage');
                        if (fileContentBase64 != null) {
                          String url = await uploadImageToFirebase(
                              "AvatarChild",
                              widget.action == UPDATE_STATE
                                  ? widget.model.id
                                  : childModel.id);
                          if (url != null && url != "") {
                            if (widget.action == UPDATE_STATE) {
                              widget.model.imageURL = url;
                            } else {
                              childModel.imageURL = url;
                            }
                          }
                        } else {
                          if (widget.action == CREATE_STATE) {
                            childModel.imageURL = defaultImage;
                          }
                        }
                        bool result = false;
                        if (widget.action == UPDATE_STATE) {
                          result = await ChildViewModel()
                              .updateChildInfo(widget.model);
                          Navigator.pop(context);
                        } else {
                          if (childModel.fingertips == null)
                            childModel.fingertips = 0;
                          if (childModel.headVortex == null)
                            childModel.headVortex = 0;
                          result = await ChildViewModel().addChild(childModel);
                          if (result == true) {
                            Navigator.pop(context);
                          }
                        }
                        Navigator.pop(context);
                        showResult(
                            context,
                            result,
                            widget.action == UPDATE_STATE
                                ? "Cập nhật thông tin thành công"
                                : "Lưu thông tin thành công");
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget MoreButton() {
    return Padding(
        padding: EdgeInsets.only(right: 20.0),
        child: GestureDetector(
          onTap: () {
            showModalBottom();
          },
          child: Icon(Icons.more_vert),
        ));
  }

  Future<dynamic> showModalBottom() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DeleteFunction(),
            ],
          );
        });
  }

  Widget DeleteFunction() {
    return ListTile(
      leading: Icon(
        Icons.delete_outline,
        color: RED_COLOR,
      ),
      title: Text(
        "Xóa thành viên",
        style: TextStyle(color: RED_COLOR),
      ),
      onTap: () async {
        Navigator.pop(context);
        showConfirmDialog(context, "Xóa thành viên", DELETE_MEMBER_MESSAGE,
            ContinueFunction: () async {
          Navigator.pop(context);
          showProgressDialogue(context);
          bool result = true;
          result = await ChildViewModel().deleteChild(widget.model.id);
          if(widget.entry == PREGNANCY_ENTRY){
            CurrentMember.pregnancyFlag = false;
            CurrentMember.pregnancyID = null;
          }
          Navigator.pop(context);
          Navigator.pop(context);
          showResult(context, result, "Xóa thành viên thành công");
        });
      },
    );
  }

  String showStatus(bool value) {
    if (value) {
      return born;
    } else {
      return notBorn;
    }
  }

  String showGender(int num) {
    switch (num) {
      /*case 0:
        return "Chưa biết";
        break;*/
      case 1:
        return "Bé trai";
        break;
      case 2:
        return "Bé gái";
        break;
      default:
        return "";
    }
  }

  int getGender(String gender) {
    switch (gender) {
      /*case "Chưa biết":
        return 0;
        break;*/
      case "Bé trai":
        return 1;
        break;
      case "Bé gái":
        return 2;
        break;
      default:
        return null;
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
    /*DropdownMenuItem(
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
    ),*/
  ];

  Widget _buildBloodGroup(String labelText, String hinText, List<String> items,
          String selectedValue, Function function) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 6),
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
