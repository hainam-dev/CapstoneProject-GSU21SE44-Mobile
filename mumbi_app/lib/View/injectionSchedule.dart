import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Widget/customComponents.dart';
import 'package:mumbi_app/View/vaccinePrice_compare.dart';
import 'package:mumbi_app/View/injectiondetail_view.dart';

class InjectionSchedule extends StatefulWidget {
  const InjectionSchedule({Key key}) : super(key: key);

  @override
  _InjectionScheduleState createState() => _InjectionScheduleState();
}

class _InjectionScheduleState extends State<InjectionSchedule> {
  int _value1 = 1;
  int _value2 = 1;
  String _chosenValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lịch tiêm chủng'),
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: () => {
            Navigator.pop(context)
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 180,
                  height: 50,
                  child: DropdownButton(
                      value: _value1,
                      items: [
                        DropdownMenuItem(
                          child: createDataWithIcon('Bé bông'),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: createDataWithIcon('Bé Bi'),
                          value: 2,
                        ),
                        DropdownMenuItem(
                            child: createDataWithIcon('Bé Mai'),
                            value: 3
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _value1 = value;
                        });
                      }),
                ),
                SizedBox(
                  width: 180,
                  height: 50,
                  child: DropdownButton<String>(
                    focusColor:Colors.white,
                    value: _chosenValue,
                    //elevation: 5,
                    style: TextStyle(color: Colors.white),
                    iconEnabledColor:Colors.black,
                    items: <String>[
                      'Chưa tiêm',
                      'Đã tiêm',
                      'Bỏ qua',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,style:TextStyle(color:Colors.black),),
                      );
                    }).toList(),
                    hint:Text(
                      "Trạng Thái",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _chosenValue = value;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
              InjectTable(),
              //InjectTable()
            ],
          ),

        ),
      ),
    );
  }
}
//
// class BabyOption  extends StatelessWidget{
//   int _value = 1;
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return  Container(
//       padding: EdgeInsets.all(20.0),
//       child: DropdownButton(
//           value: _value,
//           items: [
//             DropdownMenuItem(
//               child: Text("First Item"),
//               value: 1,
//             ),
//             DropdownMenuItem(
//               child: Text("Second Item"),
//               value: 2,
//             ),
//             DropdownMenuItem(
//                 child: Text("Third Item"),
//                 value: 3
//             ),
//             DropdownMenuItem(
//                 child: Text("Fourth Item"),
//                 value: 4
//             )
//           ],
//           onChanged: (value) {
//             setState(() {
//               _value = value;
//             });
//           }),
//     );
//   }
// }

class InjectTable extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
        onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InjectionDetail()),
      );},
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
             children: <Widget>[
               SingleChildScrollView(
                 scrollDirection: Axis.horizontal,
                 child: DataTable(
                     columnSpacing: 30.0,
                     headingRowColor: MaterialStateColor.resolveWith((states) => DARK_BLUE_COLOR),
                   dataRowColor: MaterialStateColor.resolveWith((states) => Colors.white),
                   columns: const <DataColumn>[
                     DataColumn(
                       label: Text(
                         'Ngày',style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
                       ),
                     ),
                     DataColumn(
                       label: Text(
                           'Tên Bệnh', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)
                       ),
                     ),
                     DataColumn(
                       label: Text(
                           'Mũi số',style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)
                       ),
                     ),
                     DataColumn(
                       label: Text(
                           'Trạng thái',style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)
                       ),
                     ),
                   ],
                   rows: const <DataRow>[
                     DataRow(
                       cells: <DataCell>[
                         DataCell(Text('09/05/2021')),
                         DataCell(Text('Lao')),
                         DataCell(Text('3/4')),
                         DataCell(SizedBox(
                           child: TextButton(child:Text('Chưa Tiêm')),
                         )),
                       ],
                     ),
                     DataRow(
                       cells: <DataCell>[

                         DataCell(Text('09/05/2021')),
                         DataCell(Text('Lao')),
                         DataCell(Text('3/4')),
                         DataCell(Text('Chưa tiêm')),
                       ],
                     ),
                     DataRow(
                       cells: <DataCell>[
                         DataCell(Text('09/05/2021')),
                         DataCell(Text('Lao')),
                         DataCell(Text('3/4')),
                         DataCell(Text('Chưa tiêm')),
                       ],
                     ),
                     DataRow(
                       cells: <DataCell>[
                         DataCell(Text('09/05/2021')),
                         DataCell(Text('Lao')),
                         DataCell(Text('3/4')),
                         DataCell(Text('Chưa tiêm')),
                       ],
                     ),
                   ],
                 ),
               ),
               Container(
                 padding: EdgeInsets.only(top:16),
                 child: Text(
                   'Đây là lịch dự kiến, hãy nhập mã soo của bé hoặc quét mã vạch để lấy thông tin chi tiết.',
                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                 ),
               ),
               Container(
                 padding: EdgeInsets.only(top:16),
                 child: TextButton(
                   onPressed: () => Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => VaccinePrice()),
                   ),
                   child: Row(
                     children: <Widget>[
                       Text(
                         'So sánh các loại vắc xin',
                         style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: PINK_COLOR),
                       ),
                       Icon(Icons.navigate_next)
                     ],
                   )
                 ),
               )
             ],
          ),
        ),
      ),
    );
  }
}
