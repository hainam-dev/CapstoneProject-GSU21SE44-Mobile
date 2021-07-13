import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Widget/customComponents.dart';
import 'package:mumbi_app/View/stacked.dart';
import 'package:mumbi_app/View/standard_index.dart';
import 'package:mumbi_app/View/activityDetailBaby_update.dart';
import 'package:mumbi_app/Constant/textStyle.dart';
import 'package:charts_flutter/flutter.dart' as charts;

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
        child: Column(
          children: <Widget>[
            Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Mốc phát triển',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                )),
            Container(
                padding: EdgeInsets.only(top: 16),
                alignment: Alignment.topLeft,
                child: Text(
                  'Bé của bạn đã có tiến bộ gì hơn chưa? ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                )),
            createLinear("Vận động thô", 0.7, Colors.green),
            createLinear("Vận động tinh", 0.5, Colors.orange),
            Container(
                padding: EdgeInsets.only(top: 16),
                child: createFlatButton(
                    context, 'Cập nhật sự vận động của bé', ActivityDetail())),
          ],
        ));
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
              Container(
                  width: 220,
                  // margin: EdgeInsets.only(right: 0),
                  alignment: Alignment.topRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StandardIndex()));
                      },
                      child: Text(
                        'Chỉ số tiêu chuẩn',
                        style: SEMIBOLD_13,
                      ))),
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        createListTileDetail('Nguyễn Thị Bé Bông', '24 tháng 12 ngày'),
        createListTileNext(' 21/05/2021', 'Ngày tiêm chủng sắp tới:')
      ],
    );
  }
}
