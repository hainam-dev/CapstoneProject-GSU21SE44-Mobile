import 'package:charts_flutter/flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Constant/textStyle.dart';

import 'package:mumbi_app/Widget/calendarBirthday.dart';
import 'package:mumbi_app/Widget/imagePicker.dart';
import 'package:mumbi_app/Widget/customComponents.dart';


class TeethDetail extends StatefulWidget {
  const TeethDetail({Key key}) : super(key: key);

  @override
  _TeethDetailState createState() => _TeethDetailState();
}

class _TeethDetailState extends State<TeethDetail> {

  File _image;
  final _picker = ImagePicker();

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
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 12),
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              CalendarBirthday('Ngày'),
              Container(
                padding: EdgeInsets.only(top: 12),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Răng'),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 12),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Trạng thái(*)'),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 12),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Ghi chú (nếu có)'),
                ),
              ),
              _pickerAvartar(context),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.only(top: 200, bottom: 12),
                  child: Row(
                    children: <Widget>[
                      createButtonCancel(context,'Hủy', context.widget),
                      createButtonConfirm('Cập nhật')
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget _pickerAvartar(BuildContext context){
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
                child: Row(
                children: <Widget>[
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


