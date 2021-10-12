import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:intl/intl.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Constant/textStyle.dart';
import 'package:mumbi_app/modules/family/viewmodel/child_viewmodel.dart';
import 'package:mumbi_app/modules/growing_teeth/models/teeth_model.dart';
import 'package:mumbi_app/Utils/upload_multipleImage.dart';
import 'package:mumbi_app/modules/growing_teeth/viewmodel/teeth_viewmodel.dart';
import 'package:mumbi_app/widgets/calendarBirthday.dart';
import 'package:mumbi_app/widgets/customBottomButton.dart';
import 'package:mumbi_app/widgets/customComponents.dart';
import 'package:mumbi_app/widgets/customDialog.dart';
import 'package:mumbi_app/widgets/customLoading.dart';
import 'package:mumbi_app/widgets/customProgressDialog.dart';
import 'package:mumbi_app/widgets/customStatusDropdown.dart';
import 'package:mumbi_app/widgets/customText.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class TeethDetail extends StatefulWidget {
  @override
  _TeethDetailState createState() => _TeethDetailState();
}

class _TeethDetailState extends State<TeethDetail> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<Asset> images = <Asset>[];
  List<File> _files = <File>[];
  List<String> splitImage;
  CollectionReference imgRef;
  firebase_storage.Reference ref;
  TeethModel teethModel;
  String growTimeDB;
  String growTimePick;
  String status;
  bool growFlag;
  String noteDB;
  String noteInput;
  String image;
  bool result = false;
  bool isShow = false;

  TeethViewModel teethViewModel;
  ChildViewModel childViewModel;

  String update = "Update";
  String notGrow = "Chưa mọc";
  String grow = "Đã mọc";

  @override
  void initState() {
    teethViewModel = TeethViewModel.getInstance();
    teethViewModel.getToothInfoById();

    super.initState();
    // getToothModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Mọc răng'),
      ),
      body: SingleChildScrollView(
        child: ScopedModel(
          model: teethViewModel,
          child: ScopedModelDescendant<TeethViewModel>(
              builder: (context, child, model) {
                teethModel = model.toothModel;
            // print("TOOTH MODEL: " +toothModel.note.toString());
            getToothModel();
            return Form(
              key: formKey,
              child: Container(
                padding: EdgeInsets.only(left: 16, right: 16, top: 12),
                child: Column(
                  // mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    growTimeDB == null
                        ? loadingProgress()
                        : CalendarBirthday(
                            'Ngày',
                            growTimeDB,
                            function: (value) {
                              setState(() {
                                growTimePick = value;
                              });
                            },
                          ),
                    ScopedModelDescendant<TeethViewModel>(
                        builder: (context, child, modelInfo) {
                      return createTextFeildDisable(
                          "Răng", modelInfo.toothInforModel.name);
                    }),
                    Container(
                      padding: EdgeInsets.only(top: 12),
                      child: new CustomStatusDropdown(
                        'Trạng thái (*)',
                        itemsStatus,
                        showStatus(status == notGrow),
                        function: (value) {
                          value == notGrow ? growFlag = false : growFlag = true;
                          print("growFlag" + growFlag.toString());
                          setState(
                            () {},
                          );
                        },
                      ),
                    ),
                    createTextFeild("Ghi chú (nếu có)", "", noteDB, (value) {
                      noteInput = value;
                    }),
                    ChooseImageButton(context),
                    if (teethModel.imageURL != null &&
                        teethModel.imageURL != "")
                      getDiaryImage(teethModel.imageURL),
                    CustomBottomButton(
                      titleCancel: 'Hủy',
                      titleSave: "Cập nhật",
                      cancelFunction: () => {Navigator.pop(context)},
                      saveFunction: () async {
                        if (formKey.currentState.validate()) {
                          showProgressDialogue(context);
                          List<String> listUrl = await uploadMultipleImage(
                              fileName: teethModel.childId.toString(),
                              thread: "ToothImages",
                              files: _files);
                          if (listUrl != null && listUrl != "") {
                            String url = "";
                            for (var getUrl in listUrl) {
                              if (getUrl != listUrl.last) {
                                url += getUrl + ";";
                              } else {
                                url += getUrl;
                              }
                            }
                            if (teethModel.imageURL != null &&
                                teethModel.imageURL != "") {
                              teethModel.imageURL += url;
                            } else {
                              teethModel.imageURL = url;
                            }
                          }
                          if (growTimePick != "--") {
                            teethModel.grownDate =
                                DateFormat('dd/M/yyyy').parse(growTimePick);
                          }
                          teethModel.note = noteInput;
                          print("growFlag cần update" + growFlag.toString());
                          teethModel.grownFlag = growFlag;
                          print("DATA TOOTH UPDATE: " +
                              teethModel.toothId.toString() +
                              "child:" +
                              teethModel.grownFlag.toString() +
                              teethModel.childId.toString() +
                              " " +
                              teethModel.grownDate.toString() +
                              teethModel.note.toString());
                          result =
                              await TeethViewModel().upsertTooth(teethModel);
                        }
                        Navigator.pop(context);
                        Navigator.pop(context);
                        showResult(context, result,
                            "Cập nhật thông tin răng cho bé thành công");
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  String showStatus(bool value) {
    if (value) {
      return notGrow;
    } else {
      return grow;
    }
  }

  void getToothModel() {
    if (teethModel != null && teethModel.grownFlag == true) {
      DateTime oDate = teethModel.grownDate;
      if (oDate == null) {
        growTimeDB = "--";
      } else
        growTimeDB = oDate.day.toString() +
            "/" +
            oDate.month.toString() +
            "/" +
            oDate.year.toString();
      status = grow;
      if (growFlag == null) {
        if (status == notGrow) {
          growFlag = false;
        } else
          growFlag = true;
      }

      if (teethModel.note == null) {
        noteDB = "";
      } else
        noteDB = teethModel.note;
    } else {
      status = notGrow;
      growTimeDB = "--";
      image = "";
      noteDB = "";
    }
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

  Widget ChooseImageButton(BuildContext context) {
    return GestureDetector(
      onTap: loadAssets,
      child: Container(
        padding: EdgeInsets.only(top: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Hình ảnh',
                style: SEMIBOLDPINK_16,
              ),
            ),
            showMultipleImagePicked(),
          ],
        ),
      ),
    );
  }

  Widget getDiaryImage(String _image) {
    splitImage = _image.split(";");
    return Column(
      children: [
        GridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 4,
          children: List.generate(
            splitImage.length,
            (index) {
              return Card(
                child: Stack(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: FullScreenWidget(
                      backgroundColor: WHITE_COLOR,
                      child: Center(
                        child: Hero(
                          tag: splitImage[index].toString(),
                          child: Image(
                            image:
                                CachedNetworkImageProvider(splitImage[index]),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 3,
                    top: 3,
                    child: InkWell(
                      child: Icon(
                        Icons.cancel,
                        size: 20,
                        color: PINK_COLOR,
                      ),
                      onTap: () {
                        setState(() {
                          splitImage.removeAt(index);
                          String url = "";
                          for (var getUrl in splitImage) {
                            if (getUrl != splitImage.last) {
                              url += getUrl + ";";
                            } else {
                              url += getUrl;
                            }
                          }
                          print(url);

                          teethModel.imageURL = url;
                        });
                      },
                    ),
                  ),
                ]),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget showMultipleImagePicked() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getButtonUpload(context),
        Expanded(
          child: GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 3,
            children: List.generate(_files.length, (index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(2, 0, 0, 2),
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
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: Image.file(
                                    _files[index],
                                    height: 80,
                                    width: 80,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              );
            }),
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
