import 'package:charts_flutter/flutter.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Constant/textStyle.dart';
import 'package:mumbi_app/Model/teeth_model.dart';
import 'package:mumbi_app/ViewModel/teeth_viewmodel.dart';

import 'package:mumbi_app/Widget/calendarBirthday.dart';
import 'package:mumbi_app/Widget/customBottomButton.dart';
import 'package:mumbi_app/Widget/customStatusDropdown.dart';
import 'package:mumbi_app/Widget/customText.dart';
import 'package:mumbi_app/Widget/imagePicker.dart';
import 'package:mumbi_app/Widget/customComponents.dart';
import 'package:scoped_model/scoped_model.dart';

class TeethDetail extends StatefulWidget {
  final model;
  final action;
  TeethDetail(this.action,this.model);

  @override
  _TeethDetailState createState() => _TeethDetailState();
}

class _TeethDetailState extends State<TeethDetail> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File _image;
  final _picker = ImagePicker();
  TeethModel teethModel;
  String update = "Update";

  _imgFromCamera() async {
    final image =
        await _picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      if (image != null) {
        _image = File(image.path);
      } else {
        print('No image selected.');
      }
    });
  }

  _imgFromGallery() async {
    final image =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      if (image != null) {
        _image = File(image.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Thêm từ albums'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Chụp hình'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    if(widget.action != update){
      teethModel = TeethModel();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mọc răng'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => {Navigator.pop(context)},
        ),
      ),
      body: SingleChildScrollView(
        child: ScopedModel(
        model: TeethViewModel.getInstance(),
          child: Form(
            key: formKey,
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 12),
              child: Column(
                // mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  CalendarBirthday('Ngày', widget.action == update ? widget.model.birthday : "",function: (value) {
                    /*if (value.isEmpty) {
                                              return "Vui lòng nhập ngày sinh";
                                            } else {*/
                    setState(() {
                    if(widget.action == update){
                    widget.model.growTime = value;
                    }else{
                    teethModel.growTime = value;
                    }
                    });
                    return null;},),
                  createTextFeildDisable("Răng","ahihi", (hhhh){

                  }),
                  Container(
                    padding: EdgeInsets.only(top: 12),
                    child: new CustomStatusDropdown(
                      'Trạng thái (*)',
                      itemsStatus,
                      widget.action == update ? widget.model.grownFlag : null,
                      function: (value) {
                        setState(() {
                          if(widget.action == update){
                            widget.model.grownFlag = value;
                          }else{
                            teethModel.grownFlag = value;
                          }
                          },
                        );
                      },
                    ),
                  ),
                  createTextFeild("Ghi chú (nếu có)", "Nhập ghi chú cho răng",widget.action == update ? widget.model.note : "",
                          (value){
                        setState(() {
                          if(widget.action == update){
                            widget.model.note = value;
                          }else{
                            teethModel.name = value;
                          }
                        });
                      }),
                  _pickerAvartar(context),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: createBottomNavigationBar(context, "Hủy", "Cập nhật",
          () async {
          if(formKey.currentState.validate()){
          print("OK");
          bool result = false;

          // if(appbarTitle == momTitle){
          //   result = await TeethViewModel().updateTeeth(chi, widget.model);
          }else{
            // if(widget.action == update){
            //   result = await DadViewModel().updateDad(widget.model);
            // }else{
            //   result = await DadViewModel().addDad(dadModel);
            // }
          }

        }

      ),
    );
  }

  final List<DropdownMenuItem<String>> itemsStatus = [
    DropdownMenuItem(
      value: 'Đã mọc',
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: new CustomText(
              text: 'Đã mọc',
            ),
          ),
        ],
      ),
    ),
    DropdownMenuItem(
      value: 'Chưa mọc',
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: new CustomText(
              text: 'Chưa mọc',
            ),
          ),
        ],
      ),
    ),
  ];

  Widget _pickerAvartar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showPicker(context);
      },
      child: Container(
        padding: EdgeInsets.only(top: 12),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Hình ảnh',
                style: SEMIBOLDPINK_16,
              ),
            ),
            _image != null
                ? Container(
                    padding: EdgeInsets.only(top: 8),
                    child: Row(children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            _image,
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      getButtonUpload(context)
                    ]),
                  )
                : getButtonUpload(context),
          ],
        ),
      ),
    );
  }
}
