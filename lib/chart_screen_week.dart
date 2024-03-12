import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:community_charts_flutter/community_charts_flutter.dart' as charts;

import 'data_source.dart';
import 'models/time_series.dart';

class ChartScreenDaily extends StatelessWidget {
  const ChartScreenDaily({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: FutureBuilder<WeatherChartData>(
        future: context.read<DataSource>().getChartData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          final variables = snapshot.data!.daily!;
          final axisColor = charts.MaterialPalette.gray.shadeDefault;
          return charts.TimeSeriesChart(
            [
              for (final variable in variables)
                charts.Series<TimeSeriesDatum, DateTime>(
                  id: '${variable.name} ${variable.unit}',
                  domainFn: (datum, _) => datum.domain,
                  measureFn: (datum, _) => datum.measure,
                  data: variable.values,
                ),
            ],
            domainAxis: charts.DateTimeAxisSpec(
              renderSpec: charts.SmallTickRendererSpec(
                // Tick and Label styling here.
                labelStyle: charts.TextStyleSpec(color: axisColor),
                // Change the line colors to match text color.
                lineStyle: charts.LineStyleSpec(color: axisColor),
              ),
            ),

            animate: true,
            dateTimeFactory: const charts.LocalDateTimeFactory(),
            behaviors: [charts.SeriesLegend()],
            primaryMeasureAxis: charts.NumericAxisSpec(
              renderSpec: charts.GridlineRendererSpec(
                // Tick and Label styling here.
                labelStyle: charts.TextStyleSpec(color: axisColor),
                // Change the line colors to match text color.
                lineStyle: charts.LineStyleSpec(color: axisColor),
              ),
            ),
          );
        },
      ),
    );
  }
}