import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Global/CurrentMember.dart';
import 'package:mumbi_app/Model/diary_model.dart';
import 'package:mumbi_app/Model/post_model.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/Utils/upload_multipleImage.dart';
import 'package:mumbi_app/ViewModel/child_viewmodel.dart';
import 'package:mumbi_app/ViewModel/community_viewmodel.dart';
import 'package:mumbi_app/ViewModel/diary_viewmodel.dart';
import 'package:mumbi_app/ViewModel/mom_viewmodel.dart';
import 'package:mumbi_app/Widget/createList.dart';
import 'package:mumbi_app/Widget/customDialog.dart';
import 'package:mumbi_app/Widget/customProgressDialog.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddCommunityPost extends StatefulWidget {
  @override
  _AddCommunityPostState createState() => _AddCommunityPostState();
}

class _AddCommunityPostState extends State<AddCommunityPost> {
  List<Asset> images = <Asset>[];
  List<File> _files = <File>[];
  CollectionReference imgRef;
  firebase_storage.Reference ref;
  PostModel postModel;
  MomViewModel momViewModel;
  bool postFlag;
  var decodedImage;
  @override
  void initState() {
    super.initState();
    postModel = new PostModel();

    momViewModel = MomViewModel.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        backgroundColor: WHITE_COLOR,
        appBar: AppBar(
          title: Text(
            "Tạo bài viết",
          ),
          actions: [
            AddButton(),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MomInfo(),
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
        fileName: momViewModel.momModel.id,
        thread: "PostImages",
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
      postModel.imageURL = url;
    }
    bool result = false;
    result = await CommunityViewModel().addCommunityPost(postModel);
    Navigator.pop(context);
    Navigator.pop(context);
    showResult(context, result,
        "Bài viết đã được tạo thành công và đang ở trạng thái chờ duyệt");
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
          "Đăng",
          style: TextStyle(
            color: postFlag == true ? PINK_COLOR : GREY_COLOR,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget MomInfo() {
    return ScopedModel(
        model: momViewModel,
        child: ScopedModelDescendant(
          builder: (BuildContext context, Widget child, MomViewModel model) {
            return createListTileDiaryPost(
                model.momModel.imageURL, model.momModel.fullName);
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
                      hintText: "Nội dung bài viết...",
                      focusColor: LIGHT_PINK_COLOR,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    onChanged: (value) {
                      setState(() {
                        if (value != "") {
                          postModel.postContent = value;
                          postFlag = true;
                        } else {
                          postModel.postContent = "";
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
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget showMultipleImagePicked() {
    return Column(
      children: [
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: _files.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Image.file(
                  _files[index],
                ),
                SizedBox(
                  height: 5.0,
                )
              ],
            );
          },
        ),
      ],
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 30,
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
