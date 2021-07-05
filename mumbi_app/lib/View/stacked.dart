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

class StackedAreaLineChart extends StatelessWidget {
  final String nameChart;
  final List<charts.Series> seriesList;
  final bool animate;

  StackedAreaLineChart(this.nameChart, this.seriesList, {this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory StackedAreaLineChart.withSampleData() {
    return new StackedAreaLineChart('Cân nặng',
      _createSampleData(),
      // Disable animations for image tests.
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(
        seriesList,
        defaultRenderer: new charts.LineRendererConfig(includeArea: true, stacked: true),
        animate: animate,
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final nguongTren = [
      new LinearSales(0, 2,null),
      new LinearSales(2, 4,null),
      new LinearSales(4, 6,null),
      new LinearSales(6, 7,null),
      new LinearSales(8, 8,null),
      new LinearSales(10, 9,null),
      new LinearSales(12, 10,null),
    ];

    var nguongDuoi = [
      new LinearSales(0, 4,null),
      new LinearSales(2, 5,null),
      new LinearSales(4, 6, null),
      new LinearSales(6, 7, null),
      new LinearSales(8, 8, null),
      new LinearSales(10, 10, null),
      new LinearSales(12, 12, null),
    ];

    var dataBaby = [
      new LinearSales(4, 0, [2,2]),
      new LinearSales(8, 2, [3,3]),
      new LinearSales(10, 3,[4,4]),
      new LinearSales(11, 4, [5,5]),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Desktop',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        dashPatternFn: (LinearSales sales, _) => sales.dashPattern,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: nguongDuoi,
      ),
      new charts.Series<LinearSales, int>(
        id: 'Tablet',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        dashPatternFn: (LinearSales sales, _) => sales.dashPattern,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: nguongTren,
      ),

      new charts.Series<LinearSales, int>(
        id: 'Baby',
        dashPatternFn: (LinearSales sales, _) => sales.dashPattern,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        displayName: 'Bé',
        data: dataBaby,
      ),
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;
  final List<int> dashPattern;

  LinearSales(this.year, this.sales, this.dashPattern);
}
