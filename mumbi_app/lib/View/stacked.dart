// Copyright 2018 the Charts project authors. Please see the AUTHORS file
// for details.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/// Example of a stacked area chart.
// EXCLUDE_FROM_GALLERY_DOCS_START
import 'dart:math';
// EXCLUDE_FROM_GALLERY_DOCS_END
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';


//TODO
class StackedAreaLineChart extends StatelessWidget {
  final String nameChart;
  final String desciption;
  final List<charts.Series> seriesList;
  final bool animate;

  StackedAreaLineChart(this.nameChart, this.desciption,this.seriesList, {this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory StackedAreaLineChart.withSampleData(String name, String perscent) {
    return new StackedAreaLineChart(name, perscent,
      _createSampleData(),
      // Disable animations for image tests.
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    String _formaterMonth(num year) {
      int value = year.toInt();
      return '$value th';
    }
    return new charts.LineChart(
      seriesList,
      animate: animate,
      //số trục đo dọc
      primaryMeasureAxis: new charts.NumericAxisSpec(
        tickProviderSpec:
        new charts.BasicNumericTickProviderSpec(desiredTickCount: 5),
      ),

      // số trục đo ngang
      domainAxis: new charts.NumericAxisSpec(
        // viewport: new charts.NumericExtents(2017, 2021),
          tickProviderSpec: new charts.BasicNumericTickProviderSpec(
            zeroBound: false,
            dataIsInWholeNumbers: false,
            desiredTickCount: 8,
          ),
          tickFormatterSpec: charts.BasicNumericTickFormatterSpec(
            _formaterMonth,
          ),

          //sọc vuông
          renderSpec: charts.GridlineRendererSpec( // 交叉轴刻度水平线
            tickLengthPx: 0,
            labelOffsetFromAxisPx: 12,
          )
      ),
      behaviors: [
        new charts.ChartTitle(nameChart,
            subTitle: desciption,
            behaviorPosition: charts.BehaviorPosition.top,
            titleOutsideJustification: charts.OutsideJustification.start,
            innerPadding: 18),
            // chú thích
            new charts.SeriesLegend(
              position: charts.BehaviorPosition.bottom,
              outsideJustification: charts.OutsideJustification.endDrawArea,
              // desiredMaxRows: 2,
              cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
              entryTextStyle: charts.TextStyleSpec(fontSize: 11),
            )
      ],
      defaultRenderer: new charts.LineRendererConfig(includeArea: true, stacked: true),

    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final nguongTren = [
      new LinearSales(1, 2,null),
      new LinearSales(2, 4,null),
      new LinearSales(3, 6,null),
      new LinearSales(4, 7,null),
      new LinearSales(5, 8,null),
      new LinearSales(6, 9,null),
      new LinearSales(7, 10,null),
    ];

    var nguongDuoi = [
      new LinearSales(0, 4,null),
      new LinearSales(1, 4,null),
      new LinearSales(2, 5,null),
      new LinearSales(3, 6, null),
      new LinearSales(4, 7, null),
      new LinearSales(5, 8, null),
      new LinearSales(6, 10, null),
      new LinearSales(7, 12, null),
    ];

    var dataBaby = [
      new LinearSales(1, 1, [2,2]),
      new LinearSales(5, 2, [3,3]),
      new LinearSales(6, 3,[4,4]),
      new LinearSales(7, 4, [5,5]),
      // new LinearSales(0, 4,null),
      // new LinearSales(1, 4,null),
      // new LinearSales(2, 5,null),
      // new LinearSales(3, 6, null),
      // new LinearSales(4, 7, null),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'lowerThreshold',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        dashPatternFn: (LinearSales sales, _) => sales.dashPattern,
        domainFn: (LinearSales sales, _) => sales.month,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: nguongDuoi,
        displayName: 'Ngưỡng dưới',
      ),
        new charts.Series<LinearSales, int>(
        id: 'upperThreshold',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        dashPatternFn: (dynamic sales, _) => sales.dashPattern,
        domainFn: (dynamic sales, _) => sales.month,
        measureFn: (dynamic sales, _) => sales.sales,
        data: nguongTren,
          displayName: 'Ngưỡng trên',
      ),

      new charts.Series<LinearSales, int>(
        id: 'Baby',
        dashPatternFn: (LinearSales sales, _) => sales.dashPattern,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.month,
        measureFn: (LinearSales sales, _) => sales.sales,
        displayName: 'Bé',
        data: dataBaby,
      ),
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int month;
  final int sales;
  final List<int> dashPattern;

  LinearSales(this.month, this.sales, this.dashPattern);
}
