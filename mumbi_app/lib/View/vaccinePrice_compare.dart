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
      child: SingleChildScrollView(
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
                  Text('11/07/2021', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: PINK_COLOR))
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
                        DataCell(Text('Bạch hầu')),
                        DataCell(Text('Adacel')),
                        DataCell(Text('Canada')),
                        DataCell(Text('620.000')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Bạch hầu')),
                        DataCell(Text('Boostrix')),
                        DataCell(Text('Bỉ')),
                        DataCell(Text('735.000')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Viêm gan A')),
                        DataCell(Text('Havax 0,5ml')),
                        DataCell(Text('Việt Nam')),
                        DataCell(Text('235.000')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Viêm gan A')),
                        DataCell(Text('Avaxim 80U')),
                        DataCell(Text('Pháp')),
                        DataCell(Text('590.000')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Thương hàn')),
                        DataCell(Text('Typhim VI')),
                        DataCell(Text('Pháp')),
                        DataCell(Text('281.000')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Thương hàn')),
                        DataCell(Text('Typhoid VI')),
                        DataCell(Text('Việt Nam')),
                        DataCell(Text('145.000')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Tả')),
                        DataCell(Text('mORCVAX')),
                        DataCell(Text('Việt Nam')),
                        DataCell(Text('115.000')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Sốt vàng')),
                        DataCell(Text('Stamaril')),
                        DataCell(Text('Pháp')),
                        DataCell(Text('585.000')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Viêm gan B trẻ em')),
                        DataCell(Text('Euvax B 0.5ml')),
                        DataCell(Text('Bỉ')),
                        DataCell(Text('356.000')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Viêm gan B trẻ em')),
                        DataCell(Text('Engerix B 0,5ml')),
                        DataCell(Text('Hàn Quốc')),
                        DataCell(Text('145.000')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Viêm gan B trẻ em')),
                        DataCell(Text('Hepavax Gene 0.5ml')),
                        DataCell(Text('Hà Lan')),
                        DataCell(Text('295.000')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Cúm')),
                        DataCell(Text('Influvac 0.5ml')),
                        DataCell(Text('Hà Lan')),
                        DataCell(Text('348.000')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Cúm')),
                        DataCell(Text('Influvac 0.5ml')),
                        DataCell(Text('Hà Lan')),
                        DataCell(Text('348.000')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Cúm')),
                        DataCell(Text('Influvac 0.5ml')),
                        DataCell(Text('Hà Lan')),
                        DataCell(Text('348.000')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Cúm')),
                        DataCell(Text('Influvac 0.5ml')),
                        DataCell(Text('Hà Lan')),
                        DataCell(Text('348.000')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Cúm')),
                        DataCell(Text('Influvac 0.5ml')),
                        DataCell(Text('Hà Lan')),
                        DataCell(Text('348.000')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
