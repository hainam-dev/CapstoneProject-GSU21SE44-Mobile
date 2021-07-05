import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';

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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 1.0, color: Color(0xFFFFFFFF)),
            left: BorderSide(width: 1.0, color: Color(0xFFFFFFFF)),
            right: BorderSide(width: 1.0, color: Color(0xFF000000)),
            bottom: BorderSide(width: 1.0, color: Color(0xFF000000)),
          ),
        ),
        columnSpacing: 30.0,
        dataRowHeight: 75,
        headingRowColor: MaterialStateColor.resolveWith((states) => BLACK_COLOR),
        dataRowColor: MaterialStateColor.resolveWith((states) => Colors.white),
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'Tháng',
              style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
          DataColumn(
            label: Text(
              'Chiều cao (cm)',
              style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
          DataColumn(
            label: Text(
              'Cân nặng (kg)',
              style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
          DataColumn(
            label: Text(
                'Vòng đầu',style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)
            ),
          ),
        ],
        rows: <DataRow>[
          DataRow(
            selected: true,
            cells: <DataCell>[
              DataCell.empty,
              DataCell(
                  Row(
                    mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            child: Text("Giới\n hạn\n trên")),
                        Text("Giới\n hạn\n dưới"),
                      ])),
              DataCell(
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Giới\n hạn\n trên"),
                        Text("Giới\n hạn\n dưới"),
                      ])),
              DataCell(
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Giới\n hạn\n trên"),
                        Text("Giới\n hạn\n dưới"),
                      ])),
            ],
          ),
          DataRow(
            selected: true,
            cells: <DataCell>[
              DataCell(Text('Tháng 1')),
              DataCell(
                  Row(
                    // mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('1.28'),
                        Text('1.26'),
                      ])),
              DataCell(
                  Row(
                    // mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('1.28'),
                        Text('1.26'),
                      ])),
              DataCell(
                  Row(
                    // mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('1.28'),
                        Text('1.26'),
                      ])),
            ],
          ),
          DataRow(
            selected: true,
            cells: <DataCell>[
              DataCell(Text('Tháng 2')),
              DataCell(
                  Row(
                    // mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('1.28'),
                        Text('1.26'),
                      ])),
              DataCell(
                  Row(
                    // mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('1.28'),
                        Text('1.26'),
                      ])),
              DataCell(
                  Row(
                    // mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('1.28'),
                        Text('1.26'),
                      ])),
            ],
          ),
          DataRow(
            selected: true,
            cells: <DataCell>[
              DataCell(Text('Tháng 3')),
              DataCell(
                  Row(
                    // mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('1.28'),
                        Text('1.26'),
                      ])),
              DataCell(
                  Row(
                    // mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('1.28'),
                        Text('1.26'),
                      ])),
              DataCell(
                  Row(
                    // mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('1.28'),
                        Text('1.26'),
                      ])),
            ],
          ),
        ],
      ),
    );
  }
}

