import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Global/CurrentMember.dart';
import 'package:mumbi_app/Model/diary_model.dart';
import 'package:mumbi_app/Utils/upload_multipleImage.dart';
import 'package:mumbi_app/ViewModel/child_viewmodel.dart';
import 'package:mumbi_app/ViewModel/diary_viewmodel.dart';
import 'package:mumbi_app/Widget/createList.dart';
import 'package:mumbi_app/Widget/customDialog.dart';
import 'package:mumbi_app/Widget/customProgressDialog.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddBabyDiary extends StatefulWidget {
  @override
  _AddBabyDiaryState createState() => _AddBabyDiaryState();
}

class _AddBabyDiaryState extends State<AddBabyDiary> {
  List<Asset> images = <Asset>[];
  List<File> _files = <File>[];
  CollectionReference imgRef;
  firebase_storage.Reference ref;
  DiaryModel diaryModel;
  ChildViewModel childViewModel;
  bool postFlag;
  @override
  void initState() {
    super.initState();
    diaryModel = DiaryModel();

    childViewModel = ChildViewModel.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        backgroundColor: WHITE_COLOR,
        appBar: AppBar(
          title: Text(
            "Viết nhật ký",
          ),
          actions: [
            AddButton(),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ChildInfo(),
              InputPostContent(),
              if (_files != null && _files != "") showMultipleImagePicked()
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              color: WHITE_COLOR,
              border: Border(top: BorderSide(color: GREY_COLOR))),
          child: Card(
              margin: EdgeInsets.zero,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ChooseImageButton(),
                ],
              )),
        ),
      ),
    );
  }

  void handlePost() async {
    showProgressDialogue(context);
    List<String> listUrl = await uploadMultipleImage(
        fileName: CurrentMember.id.toString(),
        thread: "DiaryImages",
        files: _files);
    if (listUrl != "" && listUrl != null) {
      String url = "";
      for (var getUrl in listUrl) {
        if (getUrl != listUrl.last) {
          url += getUrl + ";";
        } else {
          url += getUrl;
        }
      }
      diaryModel.imageURL = url;
    }
    bool result = false;
    diaryModel.childId = CurrentMember.id;
    result = await DiaryViewModel().addDiary(diaryModel);
    Navigator.pop(context);
    Navigator.pop(context);
    showResult(context, result, "Thêm nhật ký thành công");
  }

  Widget AddButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 8, 15, 8),
      child: FlatButton(
        color: postFlag == true ? WHITE_COLOR : LIGHT_GREY_COLOR,
        splashColor: postFlag == true ? LIGHT_GREY_COLOR : Colors.transparent,
        focusColor: postFlag == true ? LIGHT_GREY_COLOR : Colors.transparent,
        highlightColor:
            postFlag == true ? LIGHT_GREY_COLOR : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        onPressed: () async {
          postFlag == true ? handlePost() : null;
        },
        child: Text(
          "Lưu",
          style: TextStyle(
            color: postFlag == true ? PINK_COLOR : GREY_COLOR,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget ChildInfo() {
    return ScopedModel(
        model: childViewModel,
        child: ScopedModelDescendant(
          builder: (BuildContext context, Widget child, ChildViewModel model) {
            return createListTileDiaryPost(model.childModel.imageURL,
                model.childModel.fullName);
          },
        ));
  }

  Widget InputPostContent() {
    return Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        child: Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 5),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    minLines: 1,
                    maxLines: null,
                    autofocus: false,
                    style: TextStyle(fontSize: 19),
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
                        if (value != "") {
                          diaryModel.diaryContent = value;
                          postFlag = true;
                        } else {
                          diaryModel.diaryContent = "";
                          postFlag = false;
                        }
                      });
                    },
                  ),
                ],
              ),
            )));
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
              "Hình ảnh",
              style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }


  Widget showMultipleImagePicked() {
    return Column(
      children: [
        GridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          children: List.generate(
            _files.length,
            (index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: FullScreenWidget(
                  backgroundColor: WHITE_COLOR,
                  child: Center(
                    child: Hero(
                        tag: _files[index].toString(),
                        child: Column(
                          children: [
                            Expanded(
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.file(
                                    _files[index],
                                    height: 120,
                                    width: 120,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              );
            },
          ),
        ),
      ],
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
