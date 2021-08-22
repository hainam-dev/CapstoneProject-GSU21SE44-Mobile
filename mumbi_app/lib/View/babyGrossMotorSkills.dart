import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Constant/textStyle.dart';
import 'package:mumbi_app/Model/action_model.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/ViewModel/action_viewmodel.dart';
import 'package:mumbi_app/Widget/customDialog.dart';
import 'package:scoped_model/scoped_model.dart';

class GrossMotorSkill extends StatefulWidget {
  const GrossMotorSkill({Key key}) : super(key: key);

  @override
  _GrossMotorSkillState createState() => _GrossMotorSkillState();
}

class _GrossMotorSkillState extends State<GrossMotorSkill> {
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
    actionViewModel.getActionGross();
    actionViewModel.getAllActionByChildId();

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.only(top: 30, bottom: 30, left: 16, right: 16),
              decoration: BoxDecoration(
                color: BLACK_COLOR,
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 20,
                    child: Text(
                      'Cột Mốc',
                      style: SEMIBOLDWHITE_13,
                    ),
                  ),
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 50,
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      'Vận động thô',
                      style: SEMIBOLDWHITE_13,
                    ),
                  ),
                ],
              ),
            ),
             ScopedModel(
                  model: actionViewModel,
                  child: ScopedModelDescendant<ActionViewModel>(
                    builder: (context, child, model) {
                      list = model.listGross;
                      listMonth.clear();
                      if (list != null)
                        for (var item in list) {
                          listMonth.add(item.month);
                        }
                      Set<int> set = LinkedHashSet<int>.of(listMonth);
                      result = {
                        for (var month in set)
                          month: list.where((data) => data.month == month).toList()
                      };
                      // for(var index in result.keys)
                      //   print("index"+index.toString());
                      return Container(
                        padding: EdgeInsets.only(top: 16),
                        child: ListView.separated(
                            separatorBuilder: (context, index) => Divider(),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: result.keys.length,
                            itemBuilder: (context, index) {
                              listFlag = model.listAllAction;
                              // for (var value in result.values.elementAt(index))
                              //   value.checkedFlag = false;
                              for (var value in result.values.elementAt(index))
                                if (listFlag != null)
                                  for (var flag in listFlag)
                                    if (value.id == flag.id && flag.checkedFlag == true)
                                      value.checkedFlag = true;
                                    else value.checkedFlag = false;
                              return Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(left: 16),
                                    child: Text(
                                        result.keys.elementAt(index).toString() +
                                            ' Tháng'),
                                    width: SizeConfig.safeBlockHorizontal *
                                        20, //SET width
                                  ),
                                  Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        for (var values in result.values.elementAt(index))
                                          Container(
                                            // height: SizeConfig.safeBlockVertical*result[keys].length,
                                              width:
                                              SizeConfig.safeBlockHorizontal *
                                                  50, //SET width
                                              margin: EdgeInsets.symmetric(
                                                vertical: 10,
                                              ),
                                              child: Text(values.name)),
                                      ]),
                                  Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        for (var values in result.values.elementAt(index))
                                          IconButton(
                                            onPressed: () async {
                                              if (values.checkedFlag == null)
                                                {
                                                  values.checkedFlag = false;
                                                  print("TH1 ");}
                                              else{
                                                values.checkedFlag = await !values.checkedFlag;
                                                print("TH2");
                                              }
                                              print('values.checkedFlag' + values.checkedFlag.toString());
                                              ActionModel actionModel = new ActionModel(
                                                id: values.id,
                                                checkedFlag: values.checkedFlag,
                                              );
                                              print("actionModel" + actionModel.id.toString());
                                              resultUpdate = await actionViewModel.upsertAction(actionModel);
                                              await actionViewModel.getActionGross();
                                              await actionViewModel.getAllActionByChildId();
                                              print('chicl');
                                              showResult(context, resultUpdate, "");
                                              setState(() {});
                                            },
                                            icon:
                                            // values.id == listFlag[index].id
                                            values.checkedFlag == true
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
        ),
      ),
    );
  }
}
