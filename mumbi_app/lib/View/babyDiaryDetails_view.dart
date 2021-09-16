import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Constant/common_message.dart';
import 'package:mumbi_app/Utils/datetime_convert.dart';
import 'package:mumbi_app/ViewModel/diary_viewmodel.dart';
import 'package:mumbi_app/Widget/customConfirmDialog.dart';
import 'package:mumbi_app/Widget/customDialog.dart';
import 'package:mumbi_app/Widget/customProgressDialog.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class BabyDiaryDetails extends StatefulWidget {
  final model;

  BabyDiaryDetails(this.model);

  @override
  _BabyDiaryDetailsState createState() => _BabyDiaryDetailsState();
}

class _BabyDiaryDetailsState extends State<BabyDiaryDetails> {
  bool editFlag = false;
  int currentPos = 0;
  List<String> getImages;
  List<Asset> images = <Asset>[];
  List<File> _files = <File>[];
  CollectionReference imgRef;
  firebase_storage.Reference ref;
  @override
  void initState() {
    super.initState();
    if(getImages != null && getImages != "")
      WidgetsBinding.instance.addPostFrameCallback((_) {
        getImages.forEach((url) {
          precacheImage(NetworkImage(url), context);
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DateTimeConvert.getDayOfWeek(widget.model.createTime) + ", " +
            DateTimeConvert.convertDatetimeFullFormat(widget.model.createTime)),
        actions: [
          editFlag == false ? MoreButton() : OkAndCancelButton(),
        ],
      ),
      body: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.model.imageURL != null && widget.model.imageURL != "")
                getDiaryImage(widget.model.imageURL),
              DiaryContent(),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              color: WHITE_COLOR,
              border: Border(top: BorderSide(color: GREY_COLOR))),
          child: Card(margin: EdgeInsets.zero, child: ChooseImageButton()),
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
              EditFunction(),
              DeleteFunction(),
            ],
          );
        });
  }

  Widget EditFunction() {
    return ListTile(
      leading: Icon(Icons.create_outlined),
      title: Text("Chỉnh sửa nhật ký"),
      onTap: () {
        Navigator.pop(context);
        setState(() {
          editFlag = true;
        });
      },
    );
  }

  Widget DeleteFunction() {
    return ListTile(
      leading: Icon(
        Icons.delete_outline,
        color: RED_COLOR,
      ),
      title: Text(
        "Xóa nhật ký",
        style: TextStyle(color: RED_COLOR),
      ),
      onTap: () async {
        Navigator.pop(context);
        showConfirmDialog(
            context, "Xóa nhật ký", "Bạn có muốn xóa nhật ký này?",
            ContinueFunction: () async {
          Navigator.pop(context);
          showProgressDialogue(context);
          bool result = false;
          result = await DiaryViewModel().deleteDiary(widget.model.id);
          Navigator.pop(context);
          Navigator.pop(context);
          showResult(context, result, "Xóa nhật ký thành công");
        });
      },
    );
  }

  Widget OkAndCancelButton() {
    return Row(
      children: <Widget>[
        SizedBox(
          height: 40,
          width: 40,
          child: FittedBox(
            child: FloatingActionButton(
              backgroundColor: PINK_COLOR,
              heroTag: "Ok",
              onPressed: () async {
                showProgressDialogue(context);
                setState(() {
                  editFlag = false;
                });
                bool result = false;
                result = await DiaryViewModel().updateDiary(widget.model);
                Navigator.pop(context);
                showResult(context, result, "Chỉnh sửa nhật ký thành công");
              },
              child: Icon(
                Icons.save_outlined,
                size: 35,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        SizedBox(
          height: 40,
          width: 40,
          child: FittedBox(
            child: FloatingActionButton(
              backgroundColor: WHITE_COLOR,
              heroTag: "Cancel",
              onPressed: () {
                setState(() {
                  editFlag = false;
                });
              },
              child: Icon(
                Icons.clear_outlined,
                size: 35,
                color: PINK_COLOR,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 15,
        ),
      ],
    );
  }

  Widget DiaryContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              initialValue: widget.model.diaryContent,
              minLines: 1,
              maxLines: null,
              autofocus: editFlag,
              enabled: editFlag,
              style: TextStyle(fontSize: 18),
              decoration: InputDecoration(
                hintText: "Nội dung nhật ký...",
                focusColor: LIGHT_PINK_COLOR,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
              onChanged: (value) {
                setState(() {
                  widget.model.diaryContent = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget getDiaryImage(String _image) {
    getImages = _image.split(";");
    return Stack(
      alignment: Alignment.center,
      children: [
        Stack(
            alignment: Alignment.center,
            children: [
            CarouselSlider.builder(
            itemCount: getImages.length,
            options: CarouselOptions(
                viewportFraction: 1,
                autoPlay: true,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentPos = index;
                  });
                }),
            itemBuilder: (context, index, _) {
              return Stack(
                  children: <Widget>[
                  FullScreenWidget(
                    backgroundColor: WHITE_COLOR,
                    child: Center(
                      child: Hero(
                        tag: getImages[index].toString(),
                        child: CachedNetworkImage(
                          imageUrl: getImages[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                if (editFlag)
                  Positioned(
                    right: 5,
                    top: 5,
                    child: InkWell(
                      child: Icon(
                        Icons.cancel,
                        size: 30,
                        color: PINK_COLOR,
                      ),
                      onTap: () {
                        setState(() {
                          getImages.removeAt(index);
                          String url = "";
                          for (var getUrl in getImages) {
                            if (getUrl != getImages.last) {
                              url += getUrl + ";";
                            } else {
                              url += getUrl;
                            }
                          }
                          widget.model.imageURL = url;
                        });
                      },
                    ),
                  ),
              ]);
            },
          ),
            if (editFlag == false)
            Positioned(
              right: 10,
              top: 10,
              child: Container(
                width: 32.0,
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: BLACK_COLOR.withOpacity(0.5),
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                child: Text(
                  (currentPos + 1).toString() +
                      "/" +
                      getImages.length.toString(),
                  style: TextStyle(fontSize: 13,color: WHITE_COLOR),
                ),
              ),
            ),
            Positioned(
            bottom: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: getImages.map((pic) {
                int index = getImages.indexOf(pic);
                return Container(
                  width: currentPos == index ? 8.0 : 6.0,
                  height: currentPos == index ? 8.0 : 6.0,
                  margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: GREY_COLOR.withOpacity(0.6),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(1, 1), // changes position of shadow
                      ),
                    ],
                    color: currentPos == index
                        ? WHITE_COLOR
                        : WHITE_COLOR.withOpacity(0.6),
                  ),
                );
              }).toList(),
            ),
          ),
        ]),
      ],
    );
  }

  Widget ChooseImageButton() {
    return InkWell(
      onTap: loadAssets,
      splashColor: LIGHT_PINK_COLOR,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 10),
        child: Row(
          children: [
            Icon(
              Icons.photo_library,
              color: GREEN400,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              "Thêm hình ảnh",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Thêm hình ảnh",
          allViewTitle: "Tất cả hình ảnh",
          useDetailsView: true,
          selectCircleStrokeColor: "#ffffff",
        ),
      );
    } on Exception catch (e) {
      e.toString();
    }

    if (!mounted) return;

    setState(() {
      images = resultList;
      convertAssetToFile();
      // _error = error;
    });
  }

  Future<void> convertAssetToFile() async {
    List<File> files = <File>[];
    try {
      for (Asset asset in images) {
        final filePath =
            await FlutterAbsolutePath.getAbsolutePath(asset.identifier);
        files.add(File(filePath));
      }
    } on Exception catch (e) {
      e.toString();
    }

    if (!mounted) return;

    setState(() {
      _files = files;
    });
  }
}
