import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/Variable.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Model/child_model.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/View/childrenInfo_view.dart';
import 'package:mumbi_app/View/parentInfo_view.dart';
import 'package:mumbi_app/ViewModel/child_viewmodel.dart';
import 'package:mumbi_app/ViewModel/dad_viewmodel.dart';
import 'package:mumbi_app/ViewModel/mom_viewmodel.dart';
import 'package:mumbi_app/Widget/customComponents.dart';
import 'package:mumbi_app/Widget/customDialog.dart';
import 'package:mumbi_app/Widget/customLoading.dart';
import 'package:scoped_model/scoped_model.dart';

class MyFamily extends StatefulWidget {
  @override
  _MyFamilyState createState() => _MyFamilyState();
}

class _MyFamilyState extends State<MyFamily> {

  MomViewModel _momViewModel;
  DadViewModel _dadViewModel;
  ChildViewModel _childViewModel;
  bool isPregnant = false;

  @override
  void initState() {
    super.initState();

    _momViewModel = MomViewModel.getInstance();
    _momViewModel.getMomByID();

    _dadViewModel = DadViewModel.getInstance();
    _dadViewModel.getDadByMom();

    _childViewModel = ChildViewModel.getInstance();
    _childViewModel.getChildByMom();

  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: LIGHT_GREY_COLOR,
        appBar: AppBar(
          title: Text("Gia đình của tôi"),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ScopedModel(
                    model: _dadViewModel,
                    child: ScopedModelDescendant(builder: (BuildContext context, Widget child, DadViewModel model) {
                      return model.dadModel == null
                          ? createAddFamilyCard(
                          context, "Thêm cha",
                          onClick:()  async{
                            await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ParentInfo(DAD_APP_BAR_TITLE, "", CREATE_STATE)),
                            );
                            await _dadViewModel.getDadByMom();
                          })
                          : createFamilyCard(
                          context,
                          model.dadModel.imageURL,
                          model.dadModel.fullName,
                          LIGHT_BLUE_COLOR,
                          "Cha",
                          BLUE_COLOR,
                          onClick:() async{
                            await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ParentInfo(DAD_APP_BAR_TITLE, model.dadModel, UPDATE_STATE)),
                            );
                            await _dadViewModel.getDadByMom();
                          });
                    },)),
                ScopedModel(
                    model: _momViewModel,
                    child: ScopedModelDescendant(builder: (BuildContext context, Widget child, MomViewModel model) {
                      return model.momModel == null
                        ? loadingProgress()
                      : createFamilyCard(
                          context,
                          model.momModel.imageURL,
                          model.momModel.fullName,
                          LIGHT_PINK_COLOR,
                          isPregnant == false ? "Mẹ" : "Mẹ bầu",
                          PINK_COLOR,
                          onClick:() async{
                            await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ParentInfo(MOM_APP_BAR_TITLE, model.momModel, UPDATE_STATE)),
                            );
                            await _momViewModel.getMomByID();
                          });
                    },))
              ],
            ),
            ScopedModel(
              model: _childViewModel,
              child: ScopedModelDescendant(builder: (BuildContext context, Widget child, ChildViewModel model) {
                if(model.childListModel != null){
                  for(int i = model.childListModel.length - 1; i >= 0 ; i--){
                    ChildModel childModel = model.childListModel[i];
                    if(childModel.bornFlag == false){
                      isPregnant = true;
                      model.childListModel.removeAt(i);
                      break;
                    }
                  }
                }
                return model.childListModel == null
                    ? Align(
                    alignment: Alignment.topLeft,
                    child: createAddFamilyCard(context,
                        "Thêm bé",
                        onClick:() async{
                          await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ChildrenInfo("", CREATE_STATE,CHILD_ENTRY)),
                          );
                          await _childViewModel.getChildByMom();
                        } ))
                    : Flexible(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 250,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 0),
                      itemCount: model.childListModel.length + 1,
                      itemBuilder: (BuildContext context, index) {
                        if(index == model.childListModel.length){
                          return createAddFamilyCard(context, "Thêm bé", onClick:() async{
                            await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ChildrenInfo("", CREATE_STATE,CHILD_ENTRY)),
                            );
                            await _childViewModel.getChildByMom();
                          } );
                        }else{
                          ChildModel childModel = model.childListModel[index];
                          return createFamilyCard(
                              context,
                              childModel.imageURL,
                              childModel.fullName,
                              childModel.gender == 1 ? LIGHT_BLUE_COLOR : LIGHT_PINK_COLOR,
                              childModel.gender == 1 ? "Con trai" : "Con gái",
                              childModel.gender == 1 ? BLUE_COLOR : PINK_COLOR,
                              onClick:() async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ChildrenInfo(childModel, UPDATE_STATE, CHILD_ENTRY)),
                                );
                                await _childViewModel.getChildByMom();
                              });
                        }
                      }),
                );
              }),
            ),
          ],
        ));
  }
}
