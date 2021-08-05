import 'package:charts_flutter/flutter.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:intl/intl.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Constant/saveKey.dart';
import 'package:mumbi_app/Constant/textStyle.dart';
import 'package:mumbi_app/Model/tooth_model.dart';
import 'package:mumbi_app/View/teethTrack_view.dart';
import 'package:mumbi_app/ViewModel/child_viewmodel.dart';
import 'package:mumbi_app/ViewModel/tooth_viewmodel.dart';
import 'package:cross_file/cross_file.dart';


import 'package:mumbi_app/Widget/calendarBirthday.dart';
import 'package:mumbi_app/Widget/customBottomButton.dart';
import 'package:mumbi_app/Widget/customLoading.dart';
import 'package:mumbi_app/Widget/customStatusDropdown.dart';
import 'package:mumbi_app/Widget/customText.dart';
import 'package:mumbi_app/Widget/imagePicker.dart';
import 'package:mumbi_app/Widget/customComponents.dart';
import 'package:mumbi_app/main.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:mumbi_app/Widget/customDialog.dart';
import 'package:multi_image_picker/multi_image_picker.dart';



class TeethDetail extends StatefulWidget {
  // final model;
  // final action;
  // TeethDetail(this.action,this.model);

  @override
  _TeethDetailState createState() => _TeethDetailState();
}

class _TeethDetailState extends State<TeethDetail> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File _image;
  final ImagePicker _picker = ImagePicker();
  // ToothInfoModel teethInforModel;
  List<Asset> images = List<Asset>();
  ToothModel toothModel;
  ToothModel currentTooth;
  String growTimeDB;
  String growTimePick;
  String status;
  bool growFlag;
  String noteDB;
  String noteInput;
  String image;
  bool result = false;
  bool isShow = false;

  ToothViewModel toothViewModel;
  ChildViewModel childViewModel;


  String update = "Update";
  String notGrow = "Chưa mọc";
  String grow = "Đã mọc";

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

    final image = await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    // final List<XFile> image = await _picker.pickMultiImage(source: ImageSource.gallery);
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
  void initState() {
    toothViewModel = ToothViewModel.getInstance();
    toothViewModel.getToothInfoById();

    super.initState();
    // getToothModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mọc răng'),
        leading: backButton(context, TeethTrack())
      ),
      body: SingleChildScrollView(
        child: ScopedModel(
        model: toothViewModel,
          child: ScopedModelDescendant<ToothViewModel>(
            builder: (context,child,model){
              toothModel = model.toothModel;
              // print("TOOTH MODEL: " +toothModel.note.toString());
              getToothModel();

              return  Form(
                key: formKey,
                child: Container(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 12),
                  child: Column(
                    // mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      growTimeDB == null
                      ? loadingProgress()
                      : CalendarBirthday('Ngày', growTimeDB,function: (value) {

                        setState(() {
                          growTimePick = value;
                        });
                        },),
                      ScopedModelDescendant<ToothViewModel>(
                          builder: (context,child,modelInfo){
                            return createTextFeildDisable("Răng",modelInfo.toothInforModel.name);
                          }),
                      Container(
                        padding: EdgeInsets.only(top: 12),
                        child: new CustomStatusDropdown(
                          'Trạng thái (*)',
                          itemsStatus,
                          showStatus(status == notGrow),
                          function: (value) {
                            value == notGrow ? growFlag = false
                                : growFlag = true;
                            print("growFlag"+growFlag.toString());
                            setState(() {
                            },
                            );
                          },
                        ),
                      ),
                      createTextFeild("Ghi chú (nếu có)", "",
                          noteDB,(value){
                          noteInput = value;
                          }),
                      // _pickerAvartar(context),
                    ],
                  ),
                ),
              );
            }
          ),
        ),
      ) ,
      bottomNavigationBar: createBottomNavigationBar(context, "Hủy", "Cập nhật",
          () async {
          if(formKey.currentState.validate()){
            if (growTimePick != "--"){
              toothModel.grownDate = DateFormat('dd/M/yyyy').parse(growTimePick);
            }
            toothModel.note = noteInput;
            print("growFlag cần update"+ growFlag.toString());
            toothModel.grownFlag = growFlag;
            print("DATA TOOTH UPDATE: " + toothModel.toothId.toString() +"child:" +toothModel.grownFlag.toString()+
                toothModel.childId.toString() + " " + toothModel.grownDate.toString() + toothModel.note.toString());
            result = await ToothViewModel().upsertTooth(toothModel);
          }else{

          }
          showResult(context, result);
          }
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

  void getToothModel(){
    if(toothModel != null && toothModel.grownFlag == true){
      DateTime oDate = toothModel.grownDate;
        if(oDate == null){
          growTimeDB = "--";
        } else growTimeDB = oDate.day.toString()+"/"+oDate.month.toString() +"/"+ oDate.year.toString();
        status = grow;
        if(growFlag == null ){
          if(status == notGrow){
            growFlag = false;
          } else growFlag = true;
        }

      if(toothModel.note == null){
        noteDB = "";
      } else noteDB = toothModel.note;

    } else{
      status = notGrow;
      growTimeDB = "--";
      image= "";
      noteDB="";

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

  Widget _pickerAvartar(BuildContext context) {
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
                    child: Row(children: <Widget>[
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
  // Widget _pickerAvartar2(BuildContext context) {
  //   return GestureDetector(
  //     onTap: () {
  //       _showPicker(context);
  //     },
  //     child: Container(
  //       padding: EdgeInsets.only(top: 12),
  //       child: Column(
  //         children: <Widget>[
  //           Align(
  //             alignment: Alignment.topLeft,
  //             child: Text(
  //               'Hình ảnh',
  //               style: SEMIBOLDPINK_16,
  //             ),
  //           ),
  //           _image != null
  //               ? Container(
  //                   padding: EdgeInsets.only(top: 8),
  //                   child: Row(children: <Widget>[
  //                     Container(
  //                       padding: EdgeInsets.only(right: 16),
  //                       child: ClipRRect(
  //                         borderRadius: BorderRadius.circular(8),
  //                         child: Image.file(
  //                           _image,
  //                           height: 80,
  //                           width: 80,
  //                           fit: BoxFit.cover,
  //                         ),
  //                       ),
  //                     ),
  //                     getButtonUpload(context)
  //                   ]),
  //                 )
  //               : getButtonUpload(context),
  //         ],
  //       ),
  //     ),
  //   );
  // }

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
