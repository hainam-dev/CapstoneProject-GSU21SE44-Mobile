import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/Variable.dart';
import 'package:mumbi_app/Model/child_model.dart';
import 'package:mumbi_app/ViewModel/child_viewmodel.dart';
import 'package:mumbi_app/ViewModel/dad_viewmodel.dart';
import 'package:mumbi_app/ViewModel/mom_viewmodel.dart';
import 'package:mumbi_app/Widget/createList.dart';
import 'package:mumbi_app/Widget/customLoading.dart';
import 'package:scoped_model/scoped_model.dart';


class ChangeAccount extends StatefulWidget {
  final num;
  const ChangeAccount(this.num);

  @override
  _ChangeAccountState createState() => _ChangeAccountState();
}

class _ChangeAccountState extends State<ChangeAccount> {

  MomViewModel _momViewModel;
  DadViewModel _dadViewModel;
  ChildViewModel _childViewModel;
  String pregnancyID;

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Chuyển thành viên"),
      ),
      body: Column(
        children: [
          Mom(),
          Dad(),
          Expanded(
            child: ScopedModel(
                model: _childViewModel,
                child: ScopedModelDescendant(builder: (context, child, ChildViewModel model) {
                  if(model.childListModel != null){
                    for(int i = model.childListModel.length - 1; i >= 0 ; i--){
                      ChildModel childModel = model.childListModel[i];
                      if(childModel.bornFlag == false){
                        model.childListModel.removeAt(i);
                        pregnancyID = childModel.id;
                      }
                    }
                  }
                  return model.childListModel == null
                      ? Container()
                      : ListView.builder(
                    itemCount: model.childListModel.length,
                    itemBuilder: (context, index) {
                      ChildModel childModel = model.childListModel[index];
                      return createListTileSelectedAccount(
                          context, childModel.imageURL, childModel.fullName,childModel.id,"", CHILD_ROLE, widget.num
                      );
                    },);
                },)),
          ),
        ],
      ),
    );
  }

  Widget Mom(){
    return ScopedModel(
        model: _momViewModel,
        child: ScopedModelDescendant(builder: (context, child, MomViewModel model) {
          return model.momModel == null
          ? loadingProgress()
          : createListTileSelectedAccount(
            context, model.momModel.imageURL, model.momModel.fullName, model.momModel.id ,pregnancyID,MOM_ROLE,widget.num
          );
        },));
  }

  Widget Dad(){
    return ScopedModel(
        model: _dadViewModel,
        child: ScopedModelDescendant(builder: (context, child, DadViewModel model) {
          return model.dadModel == null
              ? Container()
              : createListTileUnselectedAccount(context, model.dadModel.imageURL, model.dadModel.fullName,"Cha");
        },));
  }

}
