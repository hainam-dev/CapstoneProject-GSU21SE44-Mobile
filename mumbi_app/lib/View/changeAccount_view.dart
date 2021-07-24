import 'package:flutter/material.dart';
import 'package:mumbi_app/Model/child_model.dart';
import 'package:mumbi_app/ViewModel/child_viewmodel.dart';
import 'package:mumbi_app/ViewModel/dad_viewmodel.dart';
import 'package:mumbi_app/ViewModel/mom_viewmodel.dart';
import 'package:mumbi_app/Widget/createList.dart';
import 'package:mumbi_app/Widget/customLoading.dart';
import 'package:scoped_model/scoped_model.dart';


class ChangeAccount extends StatefulWidget {

  @override
  _ChangeAccountState createState() => _ChangeAccountState();
}

class _ChangeAccountState extends State<ChangeAccount> {

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
                model: ChildViewModel.getInstance(),
                child: ScopedModelDescendant(builder: (context, child, ChildViewModel model) {
                  model.getChildByMom();
                  if(model.childListModel != null){
                    for(int i = model.childListModel.length - 1; i >= 0 ; i--){
                      ChildModel childModel = model.childListModel[i];
                      if(childModel.bornFlag == false){
                        model.childListModel.removeAt(i);
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
                          context, childModel.imageURL, childModel.fullName,childModel.id, "Con"
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
        model: MomViewModel.getInstance(),
        child: ScopedModelDescendant(builder: (context, child, MomViewModel model) {
          model.getMomByID();
          return createListTileSelectedAccount(
            context, model.momModel.imageURL, model.momModel.fullName,model.momModel.id,"Mẹ",
          );
        },));
  }

  Widget Dad(){
    return ScopedModel(
        model: DadViewModel.getInstance(),
        child: ScopedModelDescendant(builder: (context, child, DadViewModel model) {
          model.getDadByMom();
          return model.dadModel == null
              ? Container()
              : createListTileUnselectedAccount(context, model.dadModel.imageURL, model.dadModel.fullName,"Cha");
        },));
  }

}
