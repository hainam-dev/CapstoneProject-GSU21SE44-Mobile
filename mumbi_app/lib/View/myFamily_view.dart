import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Model/dad_model.dart';
import 'package:mumbi_app/Model/mom_model.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/View/childrenInfo_view.dart';
import 'package:mumbi_app/View/parentInfo_view.dart';
import 'package:mumbi_app/ViewModel/parent_viewmodel.dart';
import 'package:mumbi_app/Widget/customComponents.dart';

class MyFamily extends StatefulWidget {
  @override
  _MyFamilyState createState() => _MyFamilyState();
}

class _MyFamilyState extends State<MyFamily> {
  MomModel momModel;
  DadModel dadModel;
  bool isLoading = true;

  getModelForMom() async{
    ParentViewModel MomViewModel = ParentViewModel();
    await MomViewModel.getMomByID();
    momModel = MomViewModel.momModel;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getModelForMom();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Gia đình của tôi"),
        ),
        body: isLoading ? Center(child: CircularProgressIndicator()) : Container(
          height: SizeConfig.safeBlockVertical * 100,
          width: SizeConfig.safeBlockHorizontal * 100,
          color: LIGHT_GREY_COLOR,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  createAddFamilyCard(context, "Thêm cha", ParentInfo("Thông tin cha",dadModel)),
                  /*createFamilyCard(
                      context,
                      "https://file.tinnhac.com/resize/600x-/2020/06/17/20200617123908-fdf3.jpg",
                      "Nguyễn Thị Cha Jennie",
                      LIGHT_BLUE_COLOR,
                      "Cha",
                      BLUE_COLOR,
                      ParentInfo("Thông tin cha")),*/
                  createFamilyCard(
                      context,
                      momModel.image,
                      momModel.fullName,
                      LIGHT_PINK_COLOR,
                      "Mẹ",
                      PINK_COLOR,
                      ParentInfo("Thông tin mẹ",momModel)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  createFamilyCard(
                      context,
                      "https://static.wikia.nocookie.net/producerviet/images/a/a8/Lisa.jpg/revision/latest/top-crop/width/360/height/450?cb=20201124151216&path-prefix=vi",
                      "Nguyễn Thị Con Lisa",
                      LIGHT_PINK_COLOR,
                      "Con gái",
                      PINK_COLOR,
                      ChildrenInfo()),
                  createAddFamilyCard(context, "Thêm bé / thai kì", ChildrenInfo()),
                  /*createFamilyCard(
                      context,
                      "https://vtv1.mediacdn.vn/thumb_w/650/2020/8/18/jisoo01-1597719389935404726851.jpg",
                      "Nguyễn Thị Con Jisoo",
                      LIGHT_BLUE_COLOR,
                      "Con trai",
                      BLUE_COLOR,
                      ChildrenInfo()),*/
                ],
              ),
            ],
          ),
        ));
  }
}
