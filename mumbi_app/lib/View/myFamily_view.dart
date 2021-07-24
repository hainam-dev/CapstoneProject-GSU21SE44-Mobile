import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Model/child_model.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/View/childrenInfo_view.dart';
import 'package:mumbi_app/View/parentInfo_view.dart';
import 'package:mumbi_app/ViewModel/child_viewmodel.dart';
import 'package:mumbi_app/ViewModel/dad_viewmodel.dart';
import 'package:mumbi_app/ViewModel/mom_viewmodel.dart';
import 'package:mumbi_app/Widget/customComponents.dart';
import 'package:mumbi_app/Widget/customLoading.dart';
import 'package:scoped_model/scoped_model.dart';

class MyFamily extends StatefulWidget {
  @override
  _MyFamilyState createState() => _MyFamilyState();
}

class _MyFamilyState extends State<MyFamily> {

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
              ScopedModel(
                model: ChildViewModel.getInstance(),
                child: ScopedModelDescendant(builder: (BuildContext context, Widget child, ChildViewModel model) {
                  model.getChildByMom();
                  if(model.childListModel != null){
                    for(int i = model.childListModel.length - 1; i >= 0 ; i--){
                      ChildModel childModel = model.childListModel[i];
                      if(childModel.bornFlag == false){
                        model.childListModel.removeAt(i);
                      }
                    }
                  }
                  return   model.childListModel == null
                      ? Align(
                      alignment: Alignment.topLeft,
                      child: createAddFamilyCard(context,
                          "Thêm bé / thai kì", ChildrenInfo("", "Create")))
                      : Flexible(
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 250,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 0),
                        itemCount: model.childListModel.length + 1,
                        itemBuilder: (BuildContext context, index) {
                          if(index == model.childListModel.length){
                            return createAddFamilyCard(context, "Thêm bé / thai kì", ChildrenInfo("","Create"));
                          }else{
                            ChildModel childModel = model.childListModel[index];
                            return createFamilyCard(
                                context,
                                childModel.imageURL,
                                childModel.fullName,
                                childModel.gender == 1 ? LIGHT_BLUE_COLOR : LIGHT_PINK_COLOR,
                                childModel.gender == 1 ? "Con trai" : "Con gái",
                                childModel.gender == 1 ? BLUE_COLOR : PINK_COLOR,
                                ChildrenInfo(childModel,"Update"));
                          }
                        }),
                  );
                }),
              ),
            ],
          ),
        ));
  }
}
