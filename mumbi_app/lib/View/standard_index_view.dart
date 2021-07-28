import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Constant/textStyle.dart';
import 'package:mumbi_app/Model/standard_index_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:mumbi_app/ViewModel/standardIndex_viewModel.dart';
import 'package:mumbi_app/Widget/customTable.dart';
import 'package:mumbi_app/Repository/standard_index_repository.dart';

class StandardIndex extends StatefulWidget {
  const StandardIndex({Key key}) : super(key: key);

  @override
  _StandardIndexState createState() => _StandardIndexState();
}

class _StandardIndexState extends State<StandardIndex> {
  Future<StandardIndexModel> futureStand;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chỉ số tiêu chuẩn'),
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: () => {
            Navigator.pop(context)
          },
        ),
      ),
      body: ScopedModel(
        model: StandardIndexViewModel.getInstance(),
        child: ScopedModelDescendant(
          builder: (BuildContext context,Widget child, StandardIndexViewModel standrardModel) {
            standrardModel.getAllStandard();
            List<StandardIndexModel> list = standrardModel.listStandIndex;
            List<int> listMonth = [];
            var result;
            for(int i = 0; i < list.length;i++){
              for(int j = i; j < list.length; j++)
              {
                if(j == i){
                  listMonth.add(list[j].month);
                }
              }
              result = { for (var month in listMonth) month: list.where((data) => data.month == month) };
            }
            if (standrardModel != null) {
              return DrawTable(list: result);
            }
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class DrawTable extends StatelessWidget {
  Map<int, Iterable<StandardIndexModel>> list;
  DrawTable({@required this.list});
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        PaginatedDataTable(
          header: Text('Bảng chỉ sổ tiêu chuẩn'),
          rowsPerPage: 10,
          columnSpacing: 10.0,
          headingRowHeight: 40.0,
          columns: [
            DataColumn(label: Container(
              width: width * .15,
              child: Column(children: <Widget>[
                Text('Tháng',style: SEMIBOLD_13),
                Text('',style: SEMIBOLD_13)
              ],),
            ),),
            DataColumn(label: Container(
              width: width * .25,
              child: Column(children: <Widget>[
                Text('Chiều cao (cm)',style: SEMIBOLD_13),
                Text('Chỉ số trên',style: SEMIBOLD_13)
              ],),
            ),),
            DataColumn(label: Column(children: <Widget>[
              Text('',style: SEMIBOLD_13),
              Text('Chỉ số dưới',style: SEMIBOLD_13)
            ],),),
            DataColumn(label: Container(
              width: width * .25,
              child: Column(children: <Widget>[
                Text('Cân nặng (kg)',style: SEMIBOLD_13),
                Text('Chỉ số trên',style: SEMIBOLD_13)
              ],),
            ),),
            DataColumn(label: Column(children: <Widget>[
              Text('',style: SEMIBOLD_13),
              Text('Chỉ số dưới',style: SEMIBOLD_13)
            ],),),
            DataColumn(label: Container(
              width: width * .25,
              child: Column(children: <Widget>[
                Text('Vòng đầu (cm)',style: SEMIBOLD_13),
                Text('Chỉ số trên',style: SEMIBOLD_13)
              ],),
            ),),
            DataColumn(label: Column(children: <Widget>[
              Text('',style: SEMIBOLD_13),
              Text('Chỉ số dưới',style: SEMIBOLD_13)
            ],),),
          ],
          source: _DataSource(context, standarData: list),
        ),
      ],
    );
  }
}

class _Row {
  _Row(
      this.valueA,
      this.valueB,
      this.valueC,
      this.valueD,
      );

  final String valueA;
  final String valueB;
  final String valueC;
  final int valueD;

  bool selected = false;
}

class _DataSource extends DataTableSource {

  _DataSource(this.context,
      {@required Map<int, Iterable<StandardIndexModel>> standarData,
      }) : _standarData = standarData,
  assert(context != null);
  final Map<int, Iterable<StandardIndexModel>> _standarData;

  final BuildContext context;

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _standarData.length) return null;
    final _data = _standarData[index];
    return DataRow.byIndex(
      color: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected))
          return Colors.black;
        return null;  // Use the default value.
      }),
      index: index,
      cells: <DataCell>[
        DataCell(Center(child: Text('Tháng ${_data.elementAt(0).month}'))),
        DataCell(Center(child: Text('${_data.elementAt(1).maxValue.toString()}'))),
        DataCell(Center(child: Text('${_data.elementAt(1).minValue.toString()}'))) ,
        DataCell(Center(child: Text('${_data.elementAt(0).maxValue.toString()}'))),
        DataCell(Center(child: Text('${_data.elementAt(0).minValue.toString()}'))),
        DataCell(Center(child: Text('${_data.elementAt(2).maxValue.toString()}'))),
        DataCell(Center(child: Text('${_data.elementAt(2).minValue.toString()}'))),
      ],
    );
  }

  @override
  int get rowCount => _standarData.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

