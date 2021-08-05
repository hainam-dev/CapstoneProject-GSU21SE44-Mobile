import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Constant/textStyle.dart';
import 'package:mumbi_app/Model/action_model.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/ViewModel/action_viewmodel.dart';
import 'package:mumbi_app/Widget/customLoading.dart';
import 'package:scoped_model/scoped_model.dart';

class FineMotorSkill extends StatefulWidget {
  const FineMotorSkill({Key key}) : super(key: key);


  @override
  _FineMotorSkillState createState() => _FineMotorSkillState();
}

class _FineMotorSkillState extends State<FineMotorSkill> {
  List<ActionModel> list;
  ActionViewModel actionViewModel;
  Map<int, Iterable<ActionModel>> result;
  List<int> listMonth =<int>[];
  List<bool> _flag;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    actionViewModel = ActionViewModel.getInstance();
    actionViewModel.list.clear();
    actionViewModel.getActionByType("Tinh");

  }

  @override
  Widget build(BuildContext context) {
    int your_number_of_rows = 2;
    double rowHeight = (MediaQuery.of(context).size.height - 56) / your_number_of_rows;
    final double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: ScopedModel(
        model: actionViewModel,
        child: ScopedModelDescendant<ActionViewModel>(
          builder: (context,child,model) {
            list = model.list;
            listMonth.clear();
            for(int i = 0; i < list.length;i++){
                  listMonth.add(list[i].month);

            }
            Set<int> set = LinkedHashSet<int>.from(listMonth);


            result = {
              for (var month in set )
                month: list.where((data) => data.month == month)
            };
            _flag = List.generate(result.values.length, (index) => false);
            // model.getActionByActionId(2);
            // _flag[0] = model.actionModel.checkedFlag;
            for(var value in result.values){

            }
            return DataTable(
              columnSpacing: 0,
              dataRowHeight: rowHeight,
              headingRowColor: MaterialStateColor.resolveWith((
                  states) => BLACK_COLOR),
              dataRowColor: MaterialStateColor.resolveWith((states) =>
              Colors.white),
              columns: const <DataColumn>[
                DataColumn(
                 label: Text(
                  'Cột Mốc',
                    style: SEMIBOLDWHITE_13,
                  ),
                  tooltip: 'Cột mốc của bé'
                ),
                DataColumn(
                  label: Text(
                    'Vận động tinh',
                    style: SEMIBOLDWHITE_13,
                  ),
                ),
                DataColumn(
                  label: Text(
                    '',
                    style: SEMIBOLDWHITE_13,
                  ),
                ),
              ],
              rows: <DataRow>[
                for(var keys in result.keys)
                   DataRow(
                selected: true,
                cells: <DataCell>[
                  DataCell(Container(
                      child: Text(keys.toString()+ ' Tháng'),
                      width: SizeConfig.safeBlockHorizontal*15, //SET width
                    )),
                  DataCell(
                    Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for(var values in result[keys])
                          Container(
                              // height: SizeConfig.safeBlockVertical*result[keys].length,
                              width: SizeConfig.safeBlockHorizontal*50  , //SET width
                              margin: EdgeInsets.symmetric(vertical: 10,),
                              child: Text(values.name)),
                        ]),
                  ),
                  DataCell(
                      Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for(var values in result[keys])
                            Container(
                              width: SizeConfig.safeBlockHorizontal*0, //SET width
                              margin: EdgeInsets.all(10),
                              height: 30,
                              child: IconButton(
                                onPressed: () {
                                  _flag[result[keys].length] = !_flag[result[keys].length];
                                  print('chicl');
                                  setState(() {});
                                },
                                icon:
                                _flag[result[keys].length] == false
                                ? Icon(
                                  Icons.check_circle, color: GREEN400,)
                                : Icon(
                                  Icons.check_circle_outline, color: Colors.grey,),),
                            ),
                          ])),
                ].toList()

            )

              ]
            );
          },
        ),
      ),
    );
  }
}