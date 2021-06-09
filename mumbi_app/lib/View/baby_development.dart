import 'package:flutter/material.dart';
import 'package:mumbi_app/Constant/colorTheme.dart';
import 'package:mumbi_app/Widget/customComponents.dart';
import 'package:mumbi_app/View/stacked.dart';
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
          onPressed: () => {
            Navigator.pop(context)
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              BabyDetail(),
              DrawChart(),
              DrawProgress()

            ],
          ),

        ),
      ),
    );
  }
}

class DrawProgress extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              // Text('Vận Động thô'),
              LinearProgressIndicator(
                minHeight: 16,
                value: 0.7,
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            ],
          ),
          // Row(
          //   children: <Widget>[
          //     Text('Vận Động tinh'),
          //     LinearProgressIndicator(
          //       minHeight: 16,
          //       value: 0.5,
          //       backgroundColor: Colors.white,
          //       valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
          //     ),
          //   ],
          // )
        ],
      )
    );
  }
}

class DrawChart extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
        children: <Widget>[
        Text('Thể trạng của bé', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Column(children: <Widget>[
              new SizedBox(height: 250.0, child: StackedAreaLineChart.withSampleData()),
            ])),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Column(children: <Widget>[
              new SizedBox(height: 250.0, child: StackedAreaLineChart.withSampleData()),
            ])),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Column(children: <Widget>[
              new SizedBox(height: 250.0, child: StackedAreaLineChart.withSampleData()),
            ])),

      ],
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
//     // TODO: implement build
//     return new charts.LineChart(seriesList,
//         defaultRenderer:
//         new charts.LineRendererConfig(includeArea: true, stacked: true),
//         animate: animate);
//   }
//
//
// }

class BabyDetail extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        createListTileDetail('Nguyễn Thị Bé Bông','24 tháng 12 ngày'),
        createListTileNext(' 21/05/2021','Ngày tiêm chủng sắp tới:')
      ],
    );
  }
}
/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}


