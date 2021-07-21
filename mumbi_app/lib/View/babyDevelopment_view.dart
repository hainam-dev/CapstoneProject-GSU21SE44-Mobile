import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Constant/saveKey.dart';
import 'package:mumbi_app/ViewModel/child_viewmodel.dart';
import 'package:mumbi_app/Widget/customComponents.dart';
import 'package:mumbi_app/View/stacked.dart';
import 'package:mumbi_app/View/standard_index.dart';
import 'package:mumbi_app/View/activityDetailBaby_update.dart';
import 'package:mumbi_app/Constant/textStyle.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:mumbi_app/Widget/customLoading.dart';
import 'package:scoped_model/scoped_model.dart';

import '../main.dart';

class BabyDevelopment extends StatefulWidget {
  const BabyDevelopment({Key key}) : super(key: key);

  @override
  _BabyDevelopmentState createState() => _BabyDevelopmentState();
}

class _BabyDevelopmentState extends State<BabyDevelopment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theo dõi bé'),
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: () => {Navigator.pop(context)},
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[BabyDetail(), DrawChart(), DrawProgress()],
          ),
        ),
      ),
    );
  }
}

class DrawProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 16),
        color: Colors.white,
        padding: EdgeInsets.all(16),
        // child: Column(
        //   children: <Widget>[
        //     Container(
        //         alignment: Alignment.topLeft,
        //         child: Text(
        //           'Mốc phát triển',
        //           style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        //         )),
        //     Container(
        //         padding: EdgeInsets.only(top: 16),
        //         alignment: Alignment.topLeft,
        //         child: Text(
        //           'Bé của bạn đã có tiến bộ gì hơn chưa? ',
        //           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        //         )),
        //     createLinear("Vận động thô", 0.7, Colors.green),
        //     createLinear("Vận động tinh", 0.5, Colors.orange),
        //     Container(
        //         padding: EdgeInsets.only(top: 16),
        //         child: createFlatButton(
        //             context, 'Cập nhật sự vận động của bé', ActivityDetail())),
        //   ],
        // )
    );
  }
}

class DrawChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16, left: 16, right: 16),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'Thể trạng của bé',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              // Container(
              //     width: 220,
              //     // margin: EdgeInsets.only(right: 0),
              //     alignment: Alignment.topRight,
              //     child: TextButton(
              //         onPressed: () {
              //           Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) => StandardIndex()));
              //         },
              //         child: Text(
              //           'Chỉ số tiêu chuẩn',
              //           style: SEMIBOLD_13,
              //         ))),
            ],
          ),
          Container(
              // padding: const EdgeInsets.all(8.0),
              child: new Column(children: <Widget>[
            Container(
                alignment: Alignment.topLeft,
                child: Text('Cân nặng', style: SEMIBOLD_16)),
            new SizedBox(
                height: 250.0, child: StackedAreaLineChart.withSampleData()),
          ])),
          Container(
              padding: const EdgeInsets.only(top: 30.0),
              child: new Column(children: <Widget>[
                Container(
                    alignment: Alignment.topLeft,
                    child: Text('Chiều cao', style: SEMIBOLD_16)),
                new SizedBox(
                    height: 250.0,
                    child: StackedAreaLineChart.withSampleData()),
              ])),
          Container(
              padding: const EdgeInsets.only(top: 30.0),
              child: new Column(children: <Widget>[
                Container(
                    alignment: Alignment.topLeft,
                    child: Text('Chu vi đầu', style: SEMIBOLD_16)),
                new SizedBox(
                    height: 250.0,
                    child: StackedAreaLineChart.withSampleData()),
              ])),
        ],
      ),
    );
  }
}

// class StackedAreaLineChart2 extends StatelessWidget {
//   final List<charts.Series> seriesList;
//   final bool animate;
//
//   StackedAreaLineChart(this.seriesList, {this.animate});
//   @override
//   Widget build(BuildContext context) {
//     return new charts.LineChart(seriesList,
//         defaultRenderer:
//         new charts.LineRendererConfig(includeArea: true, stacked: true),
//         animate: animate);
//   }
//
//
// }

class BabyDetail extends StatelessWidget {
  String name, birthday, imageUrl;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // createListTileDetail('Nguyễn Thị Bé Bông', '24 tháng 12 ngày'),
        Container(
          // margin: EdgeInsets.all(18),
            decoration: new BoxDecoration(
              color: Colors.white,
            ),
            child: ScopedModel(
                model: ChildViewModel.getInstance(),
                child: ScopedModelDescendant(
                  builder: (BuildContext context,Widget child,ChildViewModel modelChild){
                    modelChild.getChildByMom();
                    if(modelChild.childListModel == null){
                      return loadingProgress();
                    }
                    name = modelChild.childListModel[0].fullName;
                    birthday = modelChild.childListModel[0].birthday;
                    print("birthday" + birthday);
                    DateTime dayCurrent = DateTime.parse("27/07/1997".split('/').reversed.join());
                    print("dayCurrent" +dayCurrent.toString());

                    // DateFormat date = DateFormat(‘DD/MM/YYYY').parse("27/7/1997");
                    // DateFormat dob2 = DateFormat(‘DD/MM/YYYY').parse(date);




                    // DateTime dob = DateTime.parse("2020-01-09");
                    Duration dur = DateTime.now().difference(dayCurrent);
                    String day = (dur.inDays/30).floor().toString()+" tháng " + (DateTime.now().day - dayCurrent.day).toString() +" ngày";
                    String differenceInYears = (dur.inDays/365).floor().toString()+"Năm" + (dur.inDays/365*31).floor().toString() +"ngày";
                    // print("differenceInYears" +differenceInYears);

                    imageUrl = modelChild.childListModel[0].imageURL;

                    storage.write(key: childIdKey, value: modelChild.childListModel[0].id);
                    return createListTileDetail(name, day.toString(), imageUrl);

                  },
                )
            )
        ),
        createListTileNext(' 21/05/2021', 'Ngày tiêm chủng sắp tới:'),
      ],
    );
  }
}
