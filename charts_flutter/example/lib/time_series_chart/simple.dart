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

/// Timeseries chart example
// EXCLUDE_FROM_GALLERY_DOCS_START
import 'dart:math';
// EXCLUDE_FROM_GALLERY_DOCS_END
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class SimpleTimeSeriesChart extends StatelessWidget {
  final List<charts.Series<dynamic, DateTime>> seriesList;
  final bool animate;

  SimpleTimeSeriesChart(this.seriesList, {this.animate = false});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory SimpleTimeSeriesChart.withSampleData() {
    return new SimpleTimeSeriesChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  // EXCLUDE_FROM_GALLERY_DOCS_START
  // This section is excluded from being copied to the gallery.
  // It is used for creating random series data to demonstrate animation in
  // the example app only.
  factory SimpleTimeSeriesChart.withRandomData() {
    return new SimpleTimeSeriesChart(_createRandomData());
  }

  /// Create random data.
  static List<charts.Series<TimeSeriesSales, DateTime>> _createRandomData() {
    final random = new Random();

    final data = [
      new TimeSeriesSales(new DateTime(2017, 9, 19, 15, 40, 0, 0), random.nextInt(100)),
      new TimeSeriesSales(new DateTime(2017, 9, 19, 15, 40, 1, 0), random.nextInt(100)),
      new TimeSeriesSales(new DateTime(2017, 9, 19, 15, 40, 2, 0), random.nextInt(100)),
      new TimeSeriesSales(new DateTime(2017, 9, 19, 15, 40, 3, 0), random.nextInt(100)),
      new TimeSeriesSales(new DateTime(2017, 9, 19, 15, 40, 4, 0), random.nextInt(60)),
      new TimeSeriesSales(new DateTime(2017, 9, 19, 15, 40, 5, 0), random.nextInt(100)),
      new TimeSeriesSales(new DateTime(2017, 9, 19, 15, 40, 6, 0), random.nextInt(100)),
    ];

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.red),
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
  // EXCLUDE_FROM_GALLERY_DOCS_END

  @override
  Widget build(BuildContext context) {
    // final staticTicks = <charts.TickSpec<DateTime>>[
    //   new charts.TickSpec(new DateTime(2017, 9, 19)),
    // ];
    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,

      primaryMeasureAxis: new charts.NumericAxisSpec(
        viewport: charts.NumericExtents.fromValues([0, 100]),
        // renderSpec: charts.GridlineRendererSpec(
        //     lineStyle: charts.LineStyleSpec(
        //   color: charts.ColorUtil.fromDartColor(Colors.black),
        //   dashPattern: [10, 10],
        // ))
      ),

      domainAxis: new charts.DateTimeAxisSpec(
          viewport: charts.DateTimeExtents(
              start: new DateTime(2017, 9, 19, 0, 0, 1), end: new DateTime(2017, 9, 19, 0, 0, 6)),
          renderSpec: charts.GridlineRendererSpec(
              labelOffsetFromAxisPx: 20,
              axisLineStyle: charts.LineStyleSpec(
                color: charts.ColorUtil.fromDartColor(Colors.red),
                thickness: 50,
              ),
              lineStyle: charts.LineStyleSpec(
                color: charts.ColorUtil.fromDartColor(Color(0xFFD8DDE6)),
                thickness: 1,
              )),
          tickProviderSpec: charts.SecondTickProviderSpec(increments: [1]),
          tickFormatterSpec: new charts.AutoDateTimeTickFormatterSpec(
              second: new charts.TimeFormatterSpec(format: 's сек', transitionFormat: 's'))),
      // Optionally pass in a [DateTimeFactory] used by the chart. The factory
      // should create the same type of [DateTime] as the data provided. If none
      // specified, the default creates local date time.
      dateTimeFactory: const charts.LocalDateTimeFactory(),

      behaviors: [
        new charts.PanAndZoomBehavior(),
        new charts.SlidingViewport(),
      ],
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
    final data = [
      new TimeSeriesSales(new DateTime(2017, 9, 19, 0, 0, 0), 5),
      new TimeSeriesSales(new DateTime(2017, 9, 19, 0, 0, 1), 5),
      new TimeSeriesSales(new DateTime(2017, 9, 19, 0, 0, 2), 10),
      new TimeSeriesSales(new DateTime(2017, 9, 19, 0, 0, 3), 5),
      new TimeSeriesSales(new DateTime(2017, 9, 19, 0, 0, 4), 20),
      new TimeSeriesSales(new DateTime(2017, 9, 19, 0, 0, 5), 10),
      new TimeSeriesSales(new DateTime(2017, 9, 19, 0, 0, 6), 20),
      new TimeSeriesSales(new DateTime(2017, 9, 19, 0, 0, 7), 30),
      new TimeSeriesSales(new DateTime(2017, 9, 19, 0, 0, 8), 50),
      new TimeSeriesSales(new DateTime(2017, 9, 19, 0, 0, 9), 3),
    ];

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
