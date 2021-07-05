import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Model/child_model.dart';
import 'package:mumbi_app/Model/dad_model.dart';
import 'package:mumbi_app/Model/mom_model.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/View/childrenInfo_view.dart';
import 'package:mumbi_app/View/parentInfo_view.dart';
import 'package:mumbi_app/ViewModel/child_viewmodel.dart';
import 'package:mumbi_app/ViewModel/dad_viewmodel.dart';
import 'package:mumbi_app/ViewModel/mom_viewmodel.dart';
import 'package:mumbi_app/Widget/customComponents.dart';
import 'package:scoped_model/scoped_model.dart';

class MyFamily extends StatefulWidget {
  @override
  _MyFamilyState createState() => _MyFamilyState();
}

class _MyFamilyState extends State<MyFamily> {
  /*ChildModel childModel;
  List<ChildModel> childListModel;*/

  getModel() async {
    /*ParentViewModel momViewModel = ParentViewModel();
    await momViewModel.getMomByID();
    momModel = momViewModel.momModel;

    if(momModel.dadID != null){
      ParentViewModel dadViewModel = ParentViewModel();
      await dadViewModel.getDadByMom(momModel.id);
      dadModel = dadViewModel.dadModel;
    }*/

    /*ChildViewModel childViewModel = ChildViewModel();
    await childViewModel.getChildByMom();
    childListModel = childViewModel.childListModel;

    if(childListModel.length != 0){
      for (int i = 0; i < childListModel.length; i++){
        childModel = childListModel[i];
        if(childModel.isBorn == false) {
          childListModel.removeAt(i);
        }
    }}*/
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Gia đình của tôi"),
        ),
        body: Container(
          height: SizeConfig.safeBlockVertical * 100,
          width: SizeConfig.safeBlockHorizontal * 100,
          color: LIGHT_GREY_COLOR,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ScopedModel(
                      model: DadViewModel.getInstance(),
                      child: ScopedModelDescendant(builder: (BuildContext context, Widget child, DadViewModel model) {
                        model.getDadByMom();
                        return model.dadModel == null
                            ? createAddFamilyCard(
                            context, "Thêm cha",
                            ParentInfo("Thông tin cha", "", "Create"))
                            : createFamilyCard(
                            context,
                            model.dadModel.imageURL,
                            model.dadModel.fullName,
                            LIGHT_BLUE_COLOR,
                            "Cha",
                            BLUE_COLOR,
                            ParentInfo(
                                "Thông tin cha", model.dadModel, "Update"));
                      },)),
                  ScopedModel(
                      model: MomViewModel.getInstance(),
                      child: ScopedModelDescendant(builder: (BuildContext context, Widget child, MomViewModel model) {
                        model.getMomByID();
                        return createFamilyCard(
                            context,
                            model.momModel.imageURL,
                            model.momModel.fullName,
                            LIGHT_PINK_COLOR,
                            "Mẹ",
                            PINK_COLOR,
                            ParentInfo("Thông tin mẹ", model.momModel, "Update")
                        );
                      },))
                ],
              ),
              /*childListModel.length == 0
                 ? Align(alignment: Alignment.topLeft,child: createAddFamilyCard(context, "Thêm bé / thai kì", ChildrenInfo(childListModel,"Create")))
                 :Flexible(
                   child: GridView.builder(
                       gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                         maxCrossAxisExtent: SizeConfig.safeBlockVertical * 30,
                         crossAxisSpacing: 5,
                         mainAxisSpacing: 5),
                       itemCount: childListModel.length + 1,
                       itemBuilder: (BuildContext context, index) {
                         if(index == childListModel.length){
                           return createAddFamilyCard(context, "Thêm bé / thai kì", ChildrenInfo("","Create"));
                         }else{
                           childModel = childListModel[index];
                         }
                           return createFamilyCard(
                               context,
                               childModel.image,
                               childModel.fullName,
                               childModel.gender == "Bé trai" ? LIGHT_BLUE_COLOR : LIGHT_PINK_COLOR,
                               childModel.gender == "Bé trai" ? "Con trai" : "Con gái",
                               childModel.gender == "Bé trai" ? BLUE_COLOR : PINK_COLOR,
                               ChildrenInfo(childModel,"Update"));
                       }),
                 ),
              SizedBox(height: 20,)*/
            ],
          ),
        ));
  }
}
