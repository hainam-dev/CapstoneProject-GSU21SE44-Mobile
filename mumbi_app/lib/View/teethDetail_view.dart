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
import 'package:mumbi_app/Constant/textStyle.dart';
import 'package:mumbi_app/Model/tooth_model.dart';
import 'package:mumbi_app/ViewModel/child_viewmodel.dart';
import 'package:mumbi_app/ViewModel/tooth_viewmodel.dart';

import 'package:mumbi_app/Widget/calendarBirthday.dart';
import 'package:mumbi_app/Widget/customBottomButton.dart';
import 'package:mumbi_app/Widget/customStatusDropdown.dart';
import 'package:mumbi_app/Widget/customText.dart';
import 'package:mumbi_app/Widget/imagePicker.dart';
import 'package:mumbi_app/Widget/customComponents.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:mumbi_app/Widget/customDialog.dart';

class TeethDetail extends StatefulWidget {
  final model;
  final action;
  TeethDetail(this.action,this.model);

  @override
  _TeethDetailState createState() => _TeethDetailState();
}

class _TeethDetailState extends State<TeethDetail> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File _image;
  final _picker = ImagePicker();
  // ToothInfoModel teethInforModel;
  ToothModel toothModel;
  ToothModel currentTooth;
  String growTime;
  String status;
  String note;
  String image;
  bool result = false;

  String update = "Update";

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
  void initState() {
    if(widget.action != update){
      toothModel = ToothModel();
    }
    super.initState();
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
        child: ScopedModel(
        model: ToothViewModel.getInstance(),
          child: ScopedModel(
            model: ChildViewModel.getInstance(),
            child: ScopedModelDescendant(
              builder: (BuildContext context,Widget child,ToothViewModel model){
                model.getToothByChildId();
                toothModel = model.toothModel;
                if(toothModel != null){

                  //todo: //SET TOOTH TỪ DB LÊN
                  DateTime oDate = DateTime.parse(toothModel.grownDate.toString());
                  print("DATETIME: "+ oDate.toString());
                  growTime = oDate.day.toString()+"/"+oDate.month.toString() +"/"+ oDate.year.toString();
                  note = toothModel.note;

                  if(toothModel.grownFlag){
                    status = "Đã mọc";
                  } else status = "Chưa mọc";
                } else{
                   growTime = "";
                   status = "";
                   note= "";
                   image= "";
                }



                return  Form(
                  key: formKey,
                  child: Container(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 12),
                    child: Column(
                      // mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        CalendarBirthday('Ngày', growTime,function: (DateTime value) {
                          setState(() {
                            // if(widget.action == update){
                            //   widget.model.grownDate = value;
                            // }else{

                              //todo: //SET TOOTH TỪ NHẬP VÀO
                              print("VALUE: " +value.toString());
                              print("DATETIME NE:" +DateFormat('d/M/yyyy').parse(value.toString()).toString());
                              // DateTime oDate = ;
                              toothModel.grownDate = DateFormat('d/M/yyyy').parse(value.toString());
                              print("Ngay can UPDATE: "+ DateFormat.yMd().format(value));
                            // }
                          });
                          return null;},),
                        ScopedModelDescendant(
                            builder: (BuildContext context,Widget child,ToothViewModel modelInfo){
                              modelInfo.getToothInfoById();
                              return createTextFeildDisable("Răng",modelInfo.toothInforModel.name);
                            }),
                        Container(
                          padding: EdgeInsets.only(top: 12),
                          // child: new CustomStatusDropdown(
                          //   'Trạng thái (*)',
                          //   itemsStatus,
                          //   widget.action == update ? widget.model.grownFlag : null,
                          //   function: (value) {
                          //     setState(() {
                          //       // if(widget.action == update){
                          //       //   widget.model.grownFlag = value;
                          //       // }else{
                          //       //   // teethInforModel.grownFlag = value;
                          //       // }
                          //       widget.model.status = status;
                          //     },
                          //     );
                          //   },
                          // ),
                        ),
                        createTextFeild("Ghi chú (nếu có)", "",
                            note,""),
                        _pickerAvartar(context),
                      ],
                    ),
                  ),
                );
              }
            ),
          ),
        ),
      ),
      bottomNavigationBar: createBottomNavigationBar(context, "Hủy", "Cập nhật",
          () async {
          if(formKey.currentState.validate()){
          print("OK");
          result = await ToothViewModel().upsertTooth(toothModel);

          // if(appbarTitle == momTitle){
          //   result = await TeethViewModel().updateTeeth(chi, widget.model);
          }else{
            // if(widget.action == update){
            //   result = await DadViewModel().updateDad(widget.model);
            // }else{
            //   result = await DadViewModel().addDad(dadModel);
            // }
          }
          showResult(context, result);


          }

      ),
    );
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
}
