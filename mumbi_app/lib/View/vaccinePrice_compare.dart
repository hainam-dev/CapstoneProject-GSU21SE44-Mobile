import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';

class VaccinePrice extends StatefulWidget {
  const VaccinePrice({Key key}) : super(key: key);

  @override
  _VaccinePriceState createState() => _VaccinePriceState();
}

class _VaccinePriceState extends State<VaccinePrice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bảng so sánh giá vaccine'),
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: () => {
            Navigator.pop(context)
          },
        ),
      ),
      body: VaccinePriceTable(),
    );
  }
}

class VaccinePriceTable extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top:16),
            child: Text(
              'Bảng so sánh giá vaccine',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top:16),
            child: Row(
              children: <Widget>[
                Text(
                  '* Bảng so sánh được cập nhật từ ngày ',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                ),
                Text('08/05/2021', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: PINK_COLOR))
              ],
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top:16),
            child: Text(
              '** Giá vaccine có thể thay đổi vào từng thời điểm',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700,),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top:16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 20.0,
                headingRowColor: MaterialStateColor.resolveWith((states) => DARK_BLUE_COLOR),
                dataRowColor: MaterialStateColor.resolveWith((states) => Colors.white),
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Bệnh',style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                        'Tên Vaccine', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)
                    ),
                  ),
                  DataColumn(
                    label: Text(
                        'Nước sản xuất',style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)
                    ),
                  ),
                  DataColumn(
                    label: Text(
                        'Giá tham khảo (vnđ)',style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)
                    ),
                  ),
                ],
                rows: const <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('Bạch hầu')),
                      DataCell(Text('Pentaxim')),
                      DataCell(Text('Mỹ')),
                      DataCell(Text('500.000')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('Uốn ván')),
                      DataCell(Text('Pentaxim')),
                      DataCell(Text('Mỹ')),
                      DataCell(Text('500.000')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('Viêm não Nhật Bản')),
                      DataCell(Text('Pentaxim')),
                      DataCell(Text('Mỹ')),
                      DataCell(Text('500.000')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('09/05/2021')),
                      DataCell(Text('Pentaxim')),
                      DataCell(Text('Mỹ')),
                      DataCell(Text('500.000')),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
