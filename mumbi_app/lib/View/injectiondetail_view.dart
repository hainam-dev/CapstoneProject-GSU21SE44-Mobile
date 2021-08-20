import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/textStyle.dart';
import 'package:mumbi_app/Widget/customComponents.dart';

class InjectionDetail extends StatefulWidget {
  const InjectionDetail({Key key}) : super(key: key);

  @override
  _InjectionDetailState createState() => _InjectionDetailState();
}

class _InjectionDetailState extends State<InjectionDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chi tiết tiêm chủng'),
          leading: IconButton(
            icon: Icon(Icons.keyboard_backspace),
            onPressed: () => {Navigator.pop(context)},
          ),
        ),
        body: Column(
          children: <Widget>[
            InjectionTableDetail(),
            VaccineTableDetail(),
            ButtonAction(),
          ],
        ));
  }
}

class InjectionTableDetail extends StatelessWidget {
  const InjectionTableDetail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      margin: EdgeInsets.all(16),
      color: Colors.white,
      child: DataTable(
          columnSpacing: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          columns: <DataColumn>[
            DataColumn(
              label: Text(
                'Chi tiết mũi tiêm',
                style: BOLDPINK_16,
              ),
            ),
            DataColumn(
              label: Text(''),
            )
          ],
          rows: <DataRow>[
            DataRow(cells: <DataCell>[
              DataCell(Text('Kháng viên', style: SEMIBOLD_13)),
              DataCell(Text('Viêm tai giữa, phế cầu khuẩn',
                  style: TextStyle(fontSize: 13))),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('Mũi số', style: SEMIBOLD_13)),
              DataCell(Text('1', style: TextStyle(fontSize: 13))),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('Đã tiêm', style: SEMIBOLD_13)),
              DataCell(Icon(
                Icons.check_circle,
                color: Colors.grey,
              )),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('Ngày tiêm', style: SEMIBOLD_13)),
              DataCell(
                  Text('10:00 12/03/2021', style: TextStyle(fontSize: 13))),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('Ngày tiêm', style: SEMIBOLD_13)),
              DataCell(
                  Text('Trạm Y Tế Quận 7', style: TextStyle(fontSize: 13))),
            ])
          ]),
    );
  }
}

class VaccineTableDetail extends StatelessWidget {
  const VaccineTableDetail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      margin: EdgeInsets.all(16),
      color: Colors.white,
      child: DataTable(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
          ),
          columns: <DataColumn>[
            DataColumn(
              label: Text(
                'Thông tin vaccine',
                style: BOLDPINK_16,
              ),
            ),
            DataColumn(
              label: Text(''),
            )
          ],
          rows: <DataRow>[
            DataRow(cells: <DataCell>[
              DataCell(Text('Tên Vaccine', style: SEMIBOLD_13)),
              DataCell(Text('Synflorix', style: TextStyle(fontSize: 13))),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('Số lô', style: SEMIBOLD_13)),
              DataCell(
                  Text('10:00 12/03/2021', style: TextStyle(fontSize: 13))),
            ]),
          ]),
    );
  }
}

class ButtonAction extends StatelessWidget {
  const ButtonAction({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16),
      child: Row(
        children: <Widget>[
          createButtonWhite(context, 'Đề nghị xác minh', 200, null),
          Container(
              padding: EdgeInsets.only(left: 16),
              child: createButtonWhite(context, 'Cập nhật', 150, null)),
        ],
      ),
    );
  }
}
