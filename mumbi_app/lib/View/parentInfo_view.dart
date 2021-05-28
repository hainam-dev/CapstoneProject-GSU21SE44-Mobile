import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/Widget/calendarBirthday.dart';
import 'package:mumbi_app/Widget/customText.dart';

class ParentInfo extends StatefulWidget {
  final appbarTitle;

  ParentInfo(this.appbarTitle);

  @override
  _ParentInfoState createState() => _ParentInfoState(this.appbarTitle);
}

class _ParentInfoState extends State<ParentInfo> {
  final formKey = GlobalKey<FormState>();
  String username = '';
  String dateOfBirth = '';
  String phoneNumber = '';
  final appbarTitle;
  File _image;

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

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
            _buildChangeAvatar(),
            new Container(
              height: SizeConfig.blockSizeVertical * 65,
              width: SizeConfig.blockSizeHorizontal * 90,
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    _buildUsername(),
                    const SizedBox(height: 12),
                    CalendarBirthday('Ngày sinh'),
                    const SizedBox(height: 12),
                    _buildPhoneNumber(),
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
                    _getActionButtons()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUsername() => Container(
        height: SizeConfig.blockSizeVertical * 8,
        child: TextFormField(
          decoration: InputDecoration(
            labelStyle: TextStyle(color: PINK_COLOR),
            labelText: 'Họ & tên (*)',
            hintStyle: TextStyle(color: PINK_COLOR),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: PINK_COLOR, width: 1.0),
            ),
          ),
          validator: (value) {
            if (value.length < 4) {
              return 'Enter at least 4 characters';
            } else {
              return null;
            }
          },
          onSaved: (value) => setState(() => username = value),
          keyboardType: TextInputType.name,
        ),
      );

  Widget _buildPhoneNumber() => Container(
        height: SizeConfig.blockSizeVertical * 8,
        child: TextFormField(
          decoration: InputDecoration(
            labelStyle: TextStyle(color: PINK_COLOR),
            labelText: 'Số điện thoại',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: PINK_COLOR, width: 1.0),
            ),
          ),
          validator: (value) {
            final pattern = r'((84|0[3|5|7|8|9])+([0-9]{8})\b)';
            final regExp = RegExp(pattern);
            if (value.isEmpty) {
              return 'Vui lòng nhập số điện thoại của bạn.';
            } else if (!regExp.hasMatch(value)) {
              return 'Số điện thoại không đúng, vui lòng nhập lại!';
            } else {
              return null;
            }
          },
          onSaved: (value) => setState(() => phoneNumber = value),
          keyboardType: TextInputType.phone,
        ),
      );

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

  Widget _buildChangeAvatar() => Padding(
        padding: EdgeInsets.only(top: 24.0, bottom: 26),
        child: new Center(
          child: GestureDetector(
            onTap: () {
              _showPicker(context);
            },
            child: CircleAvatar(
              radius: 65,
              backgroundColor: PINK_COLOR,
              child: _image != null
                  ? Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(65),
                          child: Image.file(
                            _image,
                            height: 125,
                            width: 125,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          right: 5,
                          bottom: 5,
                          child: CircleAvatar(
                            backgroundColor: WHITE_COLOR,
                            radius: 14.0,
                            child: new CircleAvatar(
                              backgroundColor: PINK_COLOR,
                              radius: 13.0,
                              child: Icon(
                                Icons.image_rounded,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : CircleAvatar(
                      radius: 63,
                      backgroundColor: Colors.grey[200],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt,
                            color: Colors.grey[800],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomText(
                            text: 'Chọn ảnh',
                            size: 16.0,
                          )
                        ],
                      ),
                    ),
            ),
          ),
        ),
      );

  Widget _getActionButtons() => Container(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Flexible(
              child: Container(
                height: SizeConfig.blockSizeVertical * 7,
                width: SizeConfig.blockSizeHorizontal * 35,
                child: new FlatButton(
                  child: new Text("Hủy"),
                  textColor: PINK_COLOR,
                  onPressed: () {
                    setState(() {});
                  },
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0)),
                ),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Flexible(
              child: Container(
                  height: SizeConfig.blockSizeVertical * 7,
                  width: SizeConfig.blockSizeHorizontal * 65,
                  child: new RaisedButton(
                    child: new Text("Lưu thông tin"),
                    textColor: Colors.white,
                    color: PINK_COLOR,
                    onPressed: () {
                      setState(() {});
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15.0)),
                  )),
              flex: 2,
            ),
          ],
        ),
      );
}
