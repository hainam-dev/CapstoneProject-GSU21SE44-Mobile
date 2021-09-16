import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Constant/textStyle.dart';
import 'package:mumbi_app/Model/action_model.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/ViewModel/action_viewmodel.dart';
import 'package:mumbi_app/Widget/customDialog.dart';
import 'package:mumbi_app/Widget/customProgressDialog.dart';
import 'package:scoped_model/scoped_model.dart';

class FineMotorSkill extends StatefulWidget {
  const FineMotorSkill({Key key}) : super(key: key);

  @override
  _FineMotorSkillState createState() => _FineMotorSkillState();
}

class _FineMotorSkillState extends State<FineMotorSkill> {
  List<ActionModel> list;
  List<ActionModel> listFlag;
  ActionViewModel actionViewModel;
  Map<int, Iterable<ActionModel>> result;
  List<int> listMonth = <int>[];
  bool resultUpdate = false;
  @override
  void initState() {
    super.initState();
    actionViewModel = ActionViewModel.getInstance();
    if (actionViewModel.list != null) actionViewModel.list.clear();
    actionViewModel.getActionFine();
    actionViewModel.getAllActionByChildId();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: SizeConfig.blockSizeHorizontal * 100,
          padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
          decoration: BoxDecoration(
              color: WHITE_COLOR,
              border: new Border(
                  bottom: new BorderSide(color: GREY_COLOR)
              )
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: SizeConfig.safeBlockHorizontal * 20,
                child: Text(
                  "Tháng",
                  style: TextStyle(color: BLACK_COLOR,fontWeight: FontWeight.w600,fontSize: 16),
                ),
              ),
              Container(
                width: SizeConfig.safeBlockHorizontal * 60,
                child: Text(
                  'Hành động',
                  style: TextStyle(color: BLACK_COLOR,fontWeight: FontWeight.w600,fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        ScopedModel(
          model: actionViewModel,
          child: ScopedModelDescendant<ActionViewModel>(
            builder: (context, child, model) {
              list = model.listFine;
              listMonth.clear();
              if (list != null)
                for (var item in list) {
                  listMonth.add(item.month);
                }
              Set<int> set = LinkedHashSet<int>.of(listMonth);
              result = {for (var month in set) month: list.where((data) => data.month == month).toList()};
              // for(var index in result.keys)
              //   print("index"+index.toString());
              return Expanded(
                child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(),
                    shrinkWrap: true,
                    itemCount: result.keys.length,
                    itemBuilder: (context, index) {
                      listFlag = model.listAllAction;
                      // this is the list action model in each row
                      final value = result.values.elementAt(index).toList().map((actionModel) => actionModel
                        ..checkedFlag =
                            listFlag.firstWhereOrNull((flag) => flag.id == actionModel.id)?.checkedFlag ?? false);
                      return Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 30),
                            child: Text(result.keys.elementAt(index).toString(),style: TextStyle(fontSize: 17)),
                            width: SizeConfig.safeBlockHorizontal * 20, //SET width
                          ),
                          Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (var actionModel in value)
                                  Container(
                                    // height: SizeConfig.safeBlockVertical*result[keys].length,
                                      width: SizeConfig.safeBlockHorizontal * 65, //SET width
                                      margin: EdgeInsets.symmetric(
                                        vertical: 13,
                                      ),
                                      child: Text(actionModel.name,style: TextStyle(fontSize: 16))),
                              ]),
                          Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (var actionModel in value)
                                  IconButton(
                                    onPressed: () async {
                                      showProgressDialogue(context);
                                      if (actionModel.checkedFlag == null) {
                                        actionModel.checkedFlag = false;
                                        print("TH1 ");
                                      } else {
                                        actionModel.checkedFlag = await !actionModel.checkedFlag;
                                        print("TH2");
                                      }
                                      print('values.checkedFlag' + actionModel.checkedFlag.toString());
                                      ActionModel newActionModel = new ActionModel(
                                        id: actionModel.id,
                                        checkedFlag: actionModel.checkedFlag,
                                      );
                                      print("actionModel" + newActionModel.id.toString());
                                      resultUpdate = await actionViewModel.upsertAction(newActionModel);
                                      await actionViewModel.getActionFine();
                                      await actionViewModel.getAllActionByChildId();
                                      print('chicl');
                                      setState(() {});
                                      Navigator.pop(context);
                                    },
                                    icon:
                                    actionModel.checkedFlag == true
                                        ? Icon(
                                      Icons.check_circle,
                                      color: GREEN400,
                                    )
                                        : Icon(
                                      Icons.check_circle_outline,
                                      color: Colors.grey,
                                    ),
                                  )
                              ])
                        ],
                      );
                    }),
              );
            },
          ),
        )
      ],
    );
  }
}