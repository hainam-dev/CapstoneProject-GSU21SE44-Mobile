import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:mumbi_app/Model/standard_index_model.dart';
import 'package:charts_flutter/src/text_style.dart' as style;
import 'package:charts_flutter/src/text_element.dart' as TextElement;

class StackedAreaLineChart extends StatelessWidget {
  final String nameChart;
  final String desciption;
  final List<charts.Series> seriesList;
  final bool animate;

  StackedAreaLineChart(this.nameChart, this.desciption, this.seriesList,
      {this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory StackedAreaLineChart.withSampleData(
      String name, String perscent, Iterable<StandardIndexModel> model) {
    return new StackedAreaLineChart(
      name, perscent,
      _createSampleData(model),
      // Disable animations for image tests.
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
          renderSpec: charts.GridlineRendererSpec(
            // 交叉轴刻度水平线
            tickLengthPx: 0,
            labelOffsetFromAxisPx: 12,
          )),
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
        ),
        charts.SlidingViewport(),
        charts.PanAndZoomBehavior(),
        // charts.LinePointHighlighter()
        charts.SelectNearest(eventTrigger: charts.SelectionTrigger.tapAndDrag),
        //import value point
        charts.LinePointHighlighter(
          symbolRenderer: CustomCircleSymbolRenderer(value: size),
        ),
      ],

      //set value của point ở đây
      selectionModels: [
        SelectionModelConfig(changedListener: (SelectionModel model) {
          if (model.hasDatumSelection)
            print(model.selectedSeries[0]
                .measureFn(model.selectedDatum[0].index));
        })
      ],
      //vẽ chart
      defaultRenderer: new charts.LineRendererConfig(
        includeArea: true,
        stacked: false,
        includeLine: true,
      ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData(
      Iterable<StandardIndexModel> model) {
    // print(model.toString());
    // Iterable<StandardIndexModel> modelWeight = model['Weight'];
    // Iterable<StandardIndexModel> modelHeight = model['Height'];
    // Iterable<StandardIndexModel> modelHead = model['Head'];
    List<LinearSales> listLinearMax = <LinearSales>[];
    List<LinearSales> listLinearMin = <LinearSales>[];
    for (int i = 0; i <= model.length - 1; i++) {
      listLinearMax.add(
          LinearSales(model.elementAt(i).month, model.elementAt(i).maxValue));
      // print("Tháng"+ listLinearMax[i].month.toString()+ ", Max: "+ listLinearMax[i].sales.toString());
      listLinearMin.add(
          LinearSales(model.elementAt(i).month, model.elementAt(i).minValue));
    }
    final nguongTren = [
      for (int i = 0; i <= listLinearMax.length - 1; i++) listLinearMax[i]
    ];

    var nguongDuoi = [
      for (int i = 0; i <= listLinearMax.length - 1; i++) listLinearMin[i]
    ];

    var dataBaby = [
      new LinearSales(4, 3),
      // new LinearSales(1, 2),
      new LinearSales(10, 6),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'lowerThreshold',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        // dashPatternFn: (LinearSales sales, _) => sales.dashPattern,
        domainFn: (LinearSales sales, _) => sales.month,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: nguongDuoi,
        displayName: 'Ngưỡng dưới',
      ),
      new charts.Series<LinearSales, int>(
        id: 'upperThreshold',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        // dashPatternFn: (LinearSales sales, _) => sales.dashPattern,
        domainFn: (LinearSales sales, _) => sales.month,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: nguongTren,
        displayName: 'Ngưỡng trên',
      ),
      new charts.Series<LinearSales, int>(
        id: 'Baby',
        // dashPatternFn: (LinearSales sales, _) => sales.dashPattern,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.month,
        measureFn: (LinearSales sales, _) => sales.sales,
        displayName: 'Bé',
        data: dataBaby,
      ),
    ];
  }
}

class CustomCircleSymbolRenderer extends CircleSymbolRenderer {
  final Size value;
  CustomCircleSymbolRenderer({this.value});
  @override
  void paint(ChartCanvas canvas, Rectangle<num> bounds,
      {List<int> dashPattern,
      Color fillColor,
      FillPatternType fillPattern,
      Color strokeColor,
      double strokeWidthPx}) {
    super.paint(canvas, bounds,
        dashPattern: dashPattern,
        fillColor: fillColor,
        strokeColor: strokeColor,
        strokeWidthPx: strokeWidthPx);
    canvas.drawRect(
        Rectangle(bounds.left - 5, bounds.top - 30, bounds.width + 10,
            bounds.height + 10),
        fill: Color.white);
    var textStyle = style.TextStyle();
    textStyle.color = Color.black;
    textStyle.fontSize = 15;
    canvas.drawText(TextElement.TextElement("$value", style: textStyle),
        (bounds.left).round(), (bounds.top - 28).round());
  }
}

/// Sample linear data type.
class LinearSales {
  final int month;
  final double sales;
  // final List<int> dashPattern;

  LinearSales(this.month, this.sales);
}
