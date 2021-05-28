import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/Widget/calendarBirthday.dart';
import 'package:mumbi_app/Widget/calendarCalculate.dart';
import 'package:mumbi_app/Widget/customText.dart';

class ChildrenInfo extends StatefulWidget {
  @override
  _ParentInfoState createState() => _ParentInfoState();
}

class _ParentInfoState extends State<ChildrenInfo> {
  final formKey = GlobalKey<FormState>();
  String username = '';
  String dateOfBirth = '';
  String phoneNumber = '';
  String selectedValue;
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
            _buildChangeAvatar(),
            new Container(
              height: SizeConfig.blockSizeVertical * 65,
              width: SizeConfig.blockSizeHorizontal * 90,
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    const SizedBox(height: 5),
                    _buildUsername('Họ & tên (*)'),
                    const SizedBox(height: 12),
                    _buildUsername('Tên ở nhà'),
                    const SizedBox(height: 12),
                    _buildStatus(),
                    const SizedBox(height: 12),
                    (selectedValue.toString() == "Bé đã sinh")
                        ? CalendarBirthday('Ngày sinh')
                        : (selectedValue.toString() == "Thai nhi")
                            ? CalendarCalculate()
                            : CalendarBirthday('Ngày sinh'),
                    const SizedBox(height: 12),
                    _buildGender(),
                    const SizedBox(height: 88),
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

  Widget _buildUsername(String name) => Container(
        height: SizeConfig.blockSizeVertical * 8,
        child: TextFormField(
          style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w100),
          decoration: InputDecoration(
            labelStyle: TextStyle(color: PINK_COLOR),
            labelText: name,
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

  Widget _buildStatus() => Container(
        height: SizeConfig.blockSizeVertical * 7.5,
        width: SizeConfig.blockSizeHorizontal * 90,
        child: new DropdownButtonFormField<String>(
          value: selectedValue,
          decoration: InputDecoration(
            labelStyle: TextStyle(
                color: PINK_COLOR,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                fontFamily: 'Lato'),
            labelText: 'Trạng thái(*)',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 1,
              ),
            ),
          ),

          items: [
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
          ],
          onChanged: (value) async {
            print(selectedValue = value);
            await setState(() {
              _ParentInfoState();
            });
          },
          // value: _value,
          isExpanded: true,
        ),
      );

  Widget _buildGender() => Container(
        height: SizeConfig.blockSizeVertical * 7.5,
        width: SizeConfig.blockSizeHorizontal * 90,
        child: new DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelStyle: TextStyle(
                color: PINK_COLOR,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                fontFamily: 'Lato'),
            labelText: 'Giới tính(*)',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 1,
              ),
            ),
          ),

          items: [
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
          ],
          onChanged: (value) {},
          // value: _value,
          isExpanded: true,
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
