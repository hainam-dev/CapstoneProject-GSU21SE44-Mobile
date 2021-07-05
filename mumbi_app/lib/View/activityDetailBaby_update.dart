import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/View/fineMotorSkills.dart';
import 'package:mumbi_app/View/grossMotorSkills.dart';


class ActivityDetail extends StatefulWidget {
  const ActivityDetail({Key key}) : super(key: key);

  @override
  _ActivityDetailState createState() => _ActivityDetailState();
}

class _ActivityDetailState extends State<ActivityDetail> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cập nhật hoạt động'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(child: Text('Vận động thô'),),
              Tab(child: Text('Vận động tinh'),),
            ],
          ),
          // title: Text('Cập nhật hoạt động'),
          // leading: IconButton(
          //   icon: Icon(Icons.keyboard_backspace),
          //   onPressed: () => {
          //     Navigator.pop(context)
          //   },
          // ),
        ),
        body: TabBarView(
          children: <Widget>[
            GrossMotorSkill(),
            FineMotorSkill(),
          ],
        ),
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
        dataRowHeight: 100,
        headingRowColor: MaterialStateColor.resolveWith((states) => BLACK_COLOR),
        dataRowColor: MaterialStateColor.resolveWith((states) => Colors.white),
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'Cột Mốc',
              style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
          DataColumn(
            label: Text(
              'Vận động thô',
              style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
          DataColumn(
            label: Text(
              '',
              style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
        ],
        rows: <DataRow>[
          DataRow(
            // color: MaterialStateColor.resolveWith((states) => Colors.grey),
            selected: true,
            cells: <DataCell>[
              DataCell(Text('1 Tháng')),
              DataCell(
                  Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10,),
                            height: 30,
                            child: Text('Chỉ nâng đầu')),
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            height: 30,
                            child: Text('Lật sấp')),
                      ]),
              ),
              DataCell(
                  Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          height: 30,
                          child: IconButton(
                            onPressed: () {  },
                            icon: Icon(Icons.check_circle_outline, color: Colors.grey,),),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          height: 30,
                          child: IconButton(
                            onPressed: () {  },
                            icon: Icon(Icons.check_circle, color: GREEN400,),),
                        ),
                      ])),
            ],
          ),
          DataRow(
            // color: MaterialStateColor.resolveWith((states) => Colors.grey),
            selected: true,
            cells: <DataCell>[
              DataCell(Text('2 Tháng')),
              DataCell(
                Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 10,),
                          height: 30,
                          child: Text('Chỉ nâng đầu')),
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          height: 30,
                          child: Text('Lật sấp')),
                    ]),
              ),
              DataCell(
                  Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          height: 30,
                          child: IconButton(
                            onPressed: () {  },
                            icon: Icon(Icons.check_circle_outline, color: Colors.grey,),),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          height: 30,
                          child: IconButton(
                            onPressed: () {  },
                            icon: Icon(Icons.check_circle, color: GREEN400,),),
                        ),
                      ])),
            ],
          ),
          DataRow(
            // color: MaterialStateColor.resolveWith((states) => Colors.grey),
            selected: true,
            cells: <DataCell>[
              DataCell(Text('3 Tháng')),
              DataCell(
                Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 10,),
                          height: 30,
                          child: Text('Chỉ nâng đầu')),
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          height: 30,
                          child: Text('Lật sấp')),
                    ]),
              ),
              DataCell(
                  Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          height: 30,
                          child: IconButton(
                            onPressed: () {  },
                            icon: Icon(Icons.check_circle_outline, color: Colors.grey,),),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          height: 30,
                          child: IconButton(
                            onPressed: () {  },
                            icon: Icon(Icons.check_circle, color: GREEN400,),),
                        ),
                      ])),
            ],
          ),
          DataRow(
            // color: MaterialStateColor.resolveWith((states) => Colors.grey),
            selected: true,
            cells: <DataCell>[
              DataCell(Text('4 Tháng')),
              DataCell(
                Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 10,),
                          height: 30,
                          child: Text('Chỉ nâng đầu')),
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          height: 30,
                          child: Text('Lật sấp')),
                    ]),
              ),
              DataCell(
                  Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          height: 30,
                          child: IconButton(
                            onPressed: () {  },
                            icon: Icon(Icons.check_circle_outline, color: Colors.grey,),),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          height: 30,
                          child: IconButton(
                            onPressed: () {  },
                            icon: Icon(Icons.check_circle, color: GREEN400,),),
                        ),
                      ])),
            ],
          ),

        ],
      ),
    );
  }
}

