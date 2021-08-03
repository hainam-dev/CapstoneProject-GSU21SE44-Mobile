import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Constant/textStyle.dart';
import 'package:mumbi_app/Model/action_model.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'package:mumbi_app/ViewModel/action_viewmodel.dart';
import 'package:scoped_model/scoped_model.dart';

class GrossMotorSkill extends StatefulWidget {
  const GrossMotorSkill({Key key}) : super(key: key);

  @override
  _FineMotorSkillState createState() => _FineMotorSkillState();
}

class _FineMotorSkillState extends State<GrossMotorSkill> {
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
   if(actionViewModel.list != null)
   actionViewModel.list.clear();
   actionViewModel.getActionByType("Thô");

  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: ScopedModel(
        model: actionViewModel,
        child: ScopedModelDescendant<ActionViewModel>(
          builder: (context,child,model) {
            list = model.list;
            listMonth.clear();
            if(list != null)
            for(int i = 0; i < list.length;i++){
                    listMonth.add(list[i].month);
            }
            Set<int> set = LinkedHashSet<int>.of(listMonth);
            result = {
              for (var month in set )
                month: list.where((data) => data.month == month)
            };
            return DataTable(
                columnSpacing: 0,
                dataRowHeight: 200,
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
                      'Vận động thô',
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
                                            // _flag[result[keys].length] = !_flag[result[keys].length];
                                            // print('chicl');
                                            // setState(() {});
                                          },
                                          icon:
                                          // _flag[0] == false
                                          //     ? Icon(
                                          //   Icons.check_circle, color: GREEN400,)
                                          //     :
                                          Icon(
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
