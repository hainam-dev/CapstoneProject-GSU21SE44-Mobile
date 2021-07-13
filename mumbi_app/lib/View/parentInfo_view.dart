import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Model/dad_model.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/Utils/upload_image.dart';
import 'package:mumbi_app/View/myFamily_view.dart';
import 'package:mumbi_app/ViewModel/dad_viewmodel.dart';
import 'package:mumbi_app/ViewModel/mom_viewmodel.dart';
import 'package:mumbi_app/Widget/calendarBirthday.dart';
import 'package:mumbi_app/Widget/customBottomButton.dart';
import 'package:mumbi_app/Widget/customDialog.dart';
import 'package:mumbi_app/Widget/customInputNumber.dart';
import 'package:mumbi_app/Widget/customInputText.dart';
import 'package:mumbi_app/Widget/customText.dart';
import 'package:mumbi_app/Widget/imagePicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String defaultImage = chooseImage;
  String update = "Update";
  String momTitle = "Thông tin mẹ";
  DadModel dadModel;

  @override
  void initState() {
    if(widget.action != update){
      dadModel = DadModel();
    }
    super.initState();
  }

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
        actions: <Widget>[
          if(widget.appbarTitle != momTitle && widget.action == update)
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
      backgroundColor: WHITE_COLOR,
      body: Container(
              height: SizeConfig.blockSizeVertical * 100,
              width: SizeConfig.blockSizeHorizontal * 100,
              child: Column(
                children: [
                  PickerImage(widget.action == update ? widget.model.imageURL : defaultImage),
                  const SizedBox(height: 8),
                  new Container(
                    height: SizeConfig.blockSizeVertical * 60,
                    width: SizeConfig.blockSizeHorizontal * 93,
                    child: Form(
                      key: formKey,
                      child: ListView(
                        children: [
                          CustomInputText('Họ & tên (*)', widget.action == update ? widget.model.fullName : "", function: (value){
                            setState(() {
                              if(widget.action == update){
                                widget.model.fullName = value;
                              }else{
                                dadModel.fullName = value;
                              }
                            });
                          },),
                          const SizedBox(height: 12),
                          CalendarBirthday('Ngày sinh', widget.action == update ? widget.model.birthday : "",
                            function: (value) {
                            /*if (value.isEmpty) {
                              return "Vui lòng nhập ngày sinh";
                            } else {*/
                              setState(() {
                                if(widget.action == update){
                                  widget.model.birthday = value;
                                }else{
                                  dadModel.birthday = value;
                                }
                              });
                              return null;
                            /*}*/
                          },
                          ),
                          const SizedBox(height: 17),
                          CustomInputNumber('Số điện thoại', widget.action == update ? widget.model.phoneNumber : "", function: (value){
                            setState(() {
                              if(widget.action == update){
                                widget.model.phoneNumber = value;
                              }else{
                                dadModel.phoneNumber = value;
                              }
                            });
                          }),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                child: _buildBloodGroup(
                                    'Nhóm máu', 'Nhóm máu',
                                    ['A', 'B', 'O', 'AB'],widget.action == update ? widget.model.bloodGroup : null, (value){
                                      setState(() {
                                        if(widget.action == update){
                                          widget.model.bloodGroup = value;
                                        }else{
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
                                    'Hệ máu (Rh)', 'Hệ máu (Rh)',
                                    ['RH(D)+', 'RH(D)-'],widget.action == update ? widget.model.rhBloodGroup : null, (value){
                                  setState(() {
                                    if(widget.action == update){
                                      widget.model.rhBloodGroup = value;
                                    }else{
                                      dadModel.rhBloodGroup = value;
                                    }
                                  });
                                }),
                                flex: 2,
                              ),
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  bottom: MediaQuery.of(context).viewInsets.bottom / 2)
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
          if(formKey.currentState.validate()){
            String url = await uploadImageToFirebase(widget.action == update ? widget.model.id : dadModel.id);
            if (url != null) {
              if(widget.action == update){
                widget.model.imageURL = url;
              }else{
                dadModel.imageURL = url;
              }
            }
            bool result = false;
            if(appbarTitle == momTitle){
              result = await MomViewModel().updateMom(widget.model);
            }else{
              if(widget.action == update){
                result = await DadViewModel().updateDad(widget.model);
              }else{
                result = await DadViewModel().addDad(dadModel);
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyFamily()));
              }
            }
            showResult(context,result);
          }
        },
      ),
    );
  }

  Future<void> handleClick(String value) async {
    switch (value) {
      case 'Xóa thành viên':
        bool result = false;
        result = await DadViewModel().deleteDad(widget.model.id);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyFamily()));
        showResult(context, result);
        break;
    }
  }

  Future<void> setBirthday() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String birthday = prefs.getString('GetBirthday');
    setState(() {
      widget.model.birthday = birthday;
    });
    prefs.remove('GetBirthday');
  }

  Widget _buildBloodGroup(String labelText, String hinText,
      List<String> items,String selectedValue, Function function) =>
      Container(
        height: SizeConfig.blockSizeVertical * 7,
        width: SizeConfig.blockSizeHorizontal * 45,
        child:  DropdownButtonFormField<String>(
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
