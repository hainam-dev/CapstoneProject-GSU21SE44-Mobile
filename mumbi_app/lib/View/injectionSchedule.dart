import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/assets_path.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Constant/textStyle.dart';
import 'package:mumbi_app/View/bottomNavBar_view.dart';
import 'package:mumbi_app/Widget/customComponents.dart';
import 'package:mumbi_app/View/vaccinePrice_compare.dart';
import 'package:mumbi_app/View/injectiondetail_view.dart';
import 'package:mumbi_app/Utils/size_config.dart';
import 'injectionUpdatePhone_view.dart';
import 'injectionVaccinationLogin_view.dart';

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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BotNavBar()),
            )
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
                      width: SizeConfig.safeBlockHorizontal * 40,
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
                                child: createDataWithIcon('Bé Mai'), value: 3),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _value1 = value;
                            });
                          }),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: SizeConfig.safeBlockHorizontal * 10),
                      child: SizedBox(
                        width: SizeConfig.safeBlockHorizontal * 40,
                        height: 50,
                        child: DropdownButton<String>(
                          focusColor: Colors.white,
                          value: _chosenValue,
                          //elevation: 5,
                          style: TextStyle(color: Colors.white),
                          iconEnabledColor: Colors.black,
                          items: <String>[
                            'Chưa tiêm',
                            'Đã tiêm',
                            'Bỏ qua',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                          hint: Text(
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
                      ),
                    ),
                  ],
                ),
              ),
              createTextBlueHyperlink(context, "Cập nhật lịch sử tiêm chủng",
                  InectionVaccinationLogin()),
              InjectTable(),
              //InjectTable()
            ],
          ),
        ),
      ),
    );
  }
}

class InjectTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 30.0,
                  headingRowColor: MaterialStateColor.resolveWith(
                      (states) => DARK_BLUE_COLOR),
                  dataRowColor:
                      MaterialStateColor.resolveWith((states) => Colors.white),
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        'Ngày',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    DataColumn(
                      label: Text('Tên Bệnh',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600)),
                    ),
                    DataColumn(
                      label: Text('Mũi số',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600)),
                    ),
                    DataColumn(
                      label: Text('Trạng thái',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                  rows: <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text(
                          '09/05/2021',
                          style: SEMIBOLD_13,
                        )),
                        DataCell(Text('Lao')),
                        DataCell(Text('3/4')),
                        DataCell(TableRowInkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InjectionDetail()),
                            );
                          },
                          child: TextButton(child: Text('Chưa Tiêm')),
                        )),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text(
                          '09/05/2021',
                          style: SEMIBOLD_13,
                        )),
                        DataCell(Text('Lao')),
                        DataCell(Text('3/4')),
                        DataCell(TableRowInkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InjectionDetail()),
                            );
                          },
                          child: TextButton(child: Text('Đã Tiêm')),
                        )),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text(
                          '09/05/2021',
                          style: SEMIBOLD_13,
                        )),
                        DataCell(Text('Lao')),
                        DataCell(Text('3/4')),
                        DataCell(Text('Chưa tiêm')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text(
                          '09/05/2021',
                          style: SEMIBOLD_13,
                        )),
                        DataCell(Text(
                          'Lao',
                          style: REG_13,
                        )),
                        DataCell(Text('3/4')),
                        DataCell(Text('Chưa tiêm')),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'Đây là lịch dự kiến, hãy nhập mã soo của bé hoặc quét mã vạch để lấy thông tin chi tiết.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 16),
                child: TextButton(
                    onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VaccinePrice()),
                        ),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'So sánh các loại vắc xin',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: PINK_COLOR),
                        ),
                        Icon(Icons.navigate_next)
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
