import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/Variable.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/core/change_member/models/change_member_model.dart';
import 'package:mumbi_app/modules/development_milestone/models/standard_index_model.dart';
import 'package:mumbi_app/modules/development_milestone/viewmodel/standard_index_viewmodel.dart';
import 'package:mumbi_app/modules/family/viewmodel/child_viewmodel.dart';
import 'package:mumbi_app/widgets/customEmpty.dart';
import 'package:mumbi_app/widgets/customLoading.dart';
import 'package:scoped_model/scoped_model.dart';

class StandardIndex extends StatefulWidget {
  @override
  _StandardIndexState createState() => _StandardIndexState();
}

class _StandardIndexState extends State<StandardIndex> {
  ChildViewModel childViewModel;
  StandardIndexViewModel standardIndexViewModel;
  num count;
  @override
  void initState() {
    super.initState();
    childViewModel = ChildViewModel.getInstance();

    standardIndexViewModel = StandardIndexViewModel.getInstance();
    standardIndexViewModel.getStandardIndex(
        childViewModel.childModel.gender,
        CurrentMember.role == CHILD_ROLE ? true : false
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chỉ số tiêu chuẩn'),
      ),
      body: ScopedModel(
        model: standardIndexViewModel,
        child: ScopedModelDescendant<StandardIndexViewModel>(
          builder: (BuildContext context, Widget child, StandardIndexViewModel model) {
            List<StandardIndexModel> standardIndexListModel = model.standardIndexListModel;
            List<int> listMonth = [];
            var result;
            if (standardIndexListModel != null)
              for (int i = 0; i < standardIndexListModel.length; i++) {
                for (int j = i; j < standardIndexListModel.length; j++) {
                  if (j == i) {
                    listMonth.add(standardIndexListModel[j].age);
                  }
                }
                result = {
                  for (var month in listMonth)
                    month: standardIndexListModel.where((data) => data.age == month)
                };
              }
            return model.isLoading == true
                ? loadingProgress()
                : model.standardIndexListModel == null
                ? InvisibleBox()
                : DataTable2(
                columnSpacing: 10,
                horizontalMargin: 10,
                minWidth: MediaQuery.of(context).size.width,
                columns: [
                  getColumn("Tháng\ntuổi"),
                  getColumn("Chiều cao\n(cm)"),
                  getColumn("Cân nặng\n(kg)"),
                  getColumn("Chu vi\nvòng đầu"),
                ],
                rows: [
                  DataRow(
                      cells: [
                        getCell("1"),
                        getCell("2.2"),
                        getCell("3.8"),
                        getCell("4.9"),
                      ]),
            ]);
          },
        ),
      ),
    );
  }

  DataColumn2 getColumn(String title){
    return DataColumn2(
      label: Center(
          child: Text(title,textAlign: TextAlign.center,)
      ),
      size: ColumnSize.M,
    );
  }

  DataCell getCell(String title){
    return DataCell(
      Center(
          child: Text(title,textAlign: TextAlign.center,)
      ),
    );
  }
}
