import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';

import 'customText.dart';

class PickerImage extends StatefulWidget {
  final getImage;

  const PickerImage(this.getImage);

  @override
  _PickerImageState createState() => _PickerImageState(getImage);
}

class _PickerImageState extends State<PickerImage> {
  final getImage;
  File _image;
  final _picker = ImagePicker();

  _PickerImageState(this.getImage);

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

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildChangeAvatar();
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
                  : getImage != "" ? Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(65),
                    child: Image.network(
                      getImage,
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
              ): CircleAvatar(
                      radius: 63,
                      backgroundColor: Colors.grey[200],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          getImage != null ? Image.network(getImage) :
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
}
