import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class PickImage extends StatefulWidget {
  const PickImage({Key key}) : super(key: key);

  @override
  _PickImageState createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  List<Asset> images = List<Asset>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Column(
        children: <Widget>[
          RaisedButton(
            child: Text("Pick images"),
            onPressed: pickImages,
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              children: List.generate(images.length, (index) {
                Asset asset = images[index];
                return AssetThumb(
                  asset: asset,
                  width: 50,
                  height: 50,
                );
              }),
            ),
          )
        ],
      ),
    );
  }

  Future<void> pickImages() async {
    List<Asset> resultList = List<Asset>();
    MultiImagePicker.pickImages(
      maxImages: 300,
      enableCamera: true,
      selectedAssets: images,
      materialOptions: MaterialOptions(
        actionBarTitle: "FlutterCorner.com",
      ),
    );

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        materialOptions: MaterialOptions(
          actionBarTitle: "FlutterCorner.com",
        ),
      );
    } on Exception catch (e) {
      print(e);
    }
    setState(() {
      images = resultList;
    });

  }
}
