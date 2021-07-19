import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class PickImage extends StatefulWidget {
  const PickImage({Key key}) : super(key: key);

  @override
  _PickImageState createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  List<Asset> images = List<Asset>();
  String _error;

  Widget buildGridView() {
    if (images != null)
      return GridView.count(
        crossAxisCount: 3,
        children: List.generate(images.length, (index) {
          Asset asset = images[index];
          return AssetThumb(
            asset: asset,
            width: 300,
            height: 300,
          );
        }),
      );
    else
      return Container(color: Colors.white);
  }

  Future<void> loadAssets() async {
    setState(() {
      images = List<Asset>();
    });

    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      if (error == null) _error = 'No Error Dectected';
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Column(
        children: <Widget>[
          Center(child: Text('Error: $_error')),
          RaisedButton(
            child: Text("Pick images"),
            onPressed: loadAssets,
          ),
          Expanded(
            child: buildGridView(),
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
