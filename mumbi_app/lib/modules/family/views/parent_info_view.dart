import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mumbi_app/Constant/Variable.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Constant/common_message.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/Utils/upload_image.dart';
import 'package:mumbi_app/modules/family/models/dad_model.dart';
import 'package:mumbi_app/modules/family/viewmodel/dad_viewmodel.dart';
import 'package:mumbi_app/modules/family/viewmodel/mom_viewmodel.dart';
import 'package:mumbi_app/widgets/calendarBirthday.dart';
import 'package:mumbi_app/widgets/customBottomButton.dart';
import 'package:mumbi_app/widgets/customConfirmDialog.dart';
import 'package:mumbi_app/widgets/customDialog.dart';
import 'package:mumbi_app/widgets/customInputNumber.dart';
import 'package:mumbi_app/widgets/customInputText.dart';
import 'package:mumbi_app/widgets/customProgressDialog.dart';
import 'package:mumbi_app/widgets/customText.dart';
import 'package:mumbi_app/widgets/imagePicker.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'family_view.dart';

class ParentInfo extends StatefulWidget {
  final appbarTitle;
  final model;
  final action;
  ParentInfo(this.appbarTitle, this.model, this.action);

  @override
  _ParentInfoState createState() => _ParentInfoState(this.appbarTitle);
}

class _ParentInfoState extends State<ParentInfo> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final appbarTitle;
  _ParentInfoState(this.appbarTitle);
  String pickImage = chooseImage;
  DadModel dadModel;

  @override
  void initState() {
    super.initState();
    if (widget.action != UPDATE_STATE) {
      dadModel = DadModel();
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: CustomText(
          text: '$appbarTitle',
          size: 20.0,
          color: WHITE_COLOR,
        ),
        actions: <Widget>[
          if (widget.appbarTitle != MOM_APP_BAR_TITLE &&
              widget.action == UPDATE_STATE)
            MoreButton(),
        ],
      ),
      backgroundColor: WHITE_COLOR,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                PickerImage(widget.action == UPDATE_STATE
                    ? widget.model.imageURL
                    : pickImage),
                CustomInputText(
                  'Họ & tên (*)',
                  widget.action == UPDATE_STATE ? widget.model.fullName : "",
                  function: (value) {
                    setState(() {
                      if (widget.action == UPDATE_STATE) {
                        widget.model.fullName = value;
                      } else {
                        dadModel.fullName = value;
                      }
                    });
                  },
                ),
                CalendarBirthday(
                  PARENT_BIRTHDAY_FIELD,
                  widget.action == UPDATE_STATE ? widget.model.birthday : "",
                  function: (value) {
                    setState(() {
                      if (widget.action == UPDATE_STATE) {
                        widget.model.birthday = value;
                      } else {
                        dadModel.birthday = value;
                      }
                    });
                    return null;
                  },
                ),
                CustomInputNumber(
                    'Số điện thoại',
                    widget.action == UPDATE_STATE
                        ? widget.model.phoneNumber
                        : "", function: (value) {
                  setState(() {
                    if (widget.action == UPDATE_STATE) {
                      widget.model.phoneNumber = value;
                    } else {
                      dadModel.phoneNumber = value;
                    }
                  });
                }),
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
                            dadModel.bloodGroup = value;
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
                            dadModel.rhBloodGroup = value;
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
                      : 'Lưu thông tin',
                  cancelFunction: () => {Navigator.pop(context)},
                  saveFunction: () async {
                    if (formKey.currentState.validate()) {
                      showProgressDialogue(context);
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      String fileContentBase64 = prefs.getString('UserImage');
                      if (fileContentBase64 != null) {
                        String url = await uploadImageToFirebase(
                            "AvatarParent",
                            widget.action == UPDATE_STATE
                                ? widget.model.id
                                : dadModel.id);
                        if (url != null) {
                          if (widget.action == UPDATE_STATE) {
                            widget.model.imageURL = url;
                          } else {
                            dadModel.imageURL = url;
                          }
                        }
                      } else {
                        if (widget.action == CREATE_STATE) {
                          dadModel.imageURL = defaultImage;
                        }
                      }
                      bool result = false;
                      if (appbarTitle == MOM_APP_BAR_TITLE) {
                        result = await MomViewModel().updateMom(widget.model);
                      } else {
                        if (widget.action == UPDATE_STATE) {
                          result = await DadViewModel().updateDad(widget.model);
                        } else {
                          result = await DadViewModel().addDad(dadModel);
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
                  },
                ),
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
          result = await DadViewModel().deleteDad(widget.model.id);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Family(),
              ));
          showResult(context, result, "Xóa thành viên thành công");
        });
      },
    );
  }

  Future<void> setBirthday() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String birthday = prefs.getString('GetBirthday');
    setState(() {
      widget.model.birthday = birthday;
    });
    prefs.remove('GetBirthday');
  }

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
