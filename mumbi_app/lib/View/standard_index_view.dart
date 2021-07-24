import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Constant/textStyle.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:mumbi_app/ViewModel/standardIndex_viewModel.dart';
import 'package:mumbi_app/Widget/customTable.dart';

class StandardIndex extends StatefulWidget {
  const StandardIndex({Key key}) : super(key: key);

  @override
  _StandardIndexState createState() => _StandardIndexState();
}

class _StandardIndexState extends State<StandardIndex> {
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
      body: Container(
        child: DrawTable(),
      ),
    );
  }
}

class DrawTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        PaginatedDataTable(
          header: Text('Bảng chỉ sổ tiêu chuẩn'),
          rowsPerPage: 4,
          // : MaterialStateColor.resolveWith((states) => BLACK_COLOR),
          columns: [
            DataColumn(label: Text("Tháng",style: SEMIBOLD_13),),
            DataColumn(label: Text('Chiều cao (cm)',style: SEMIBOLD_13),),
            DataColumn(label: Text('Cân nặng (kg)',style: SEMIBOLD_13),),
            DataColumn(label: Text('Vòng đầu',style: SEMIBOLD_13),),
          ],
          source: _DataSource(context),
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
  _DataSource(this.context) {
    _rows = <_Row>[
      _Row('Cell A1', 'CellB1', 'CellC1', 1),
      _Row('Cell A2', 'CellB2', 'CellC2', 2),
      _Row('Cell A3', 'CellB3', 'CellC3', 3),
      _Row('Cell A4', 'CellB4', 'CellC4', 4),
    ];
  }

  final BuildContext context;
  List<_Row> _rows;

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _rows.length) return null;
    final row = _rows[index];
    return DataRow.byIndex(
      index: index,
      selected: row.selected,
      onSelectChanged: (value) {
        if (row.selected != value) {
          _selectedCount += value ? 1 : -1;
          assert(_selectedCount >= 0);
          row.selected = value;
          notifyListeners();
        }
      },
      cells: [
        DataCell(Text(row.valueA)),
        DataCell(Text(row.valueB)),
        DataCell(Text(row.valueC)),
        DataCell(Text(row.valueD.toString())),
      ],
    );
  }

  @override
  int get rowCount => _rows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

