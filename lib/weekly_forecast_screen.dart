import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/data_source.dart';

import 'package:weather/models.dart';
import 'weather_sliver_app_bar.dart';
import 'weekly_forcasf_list.dart';

class WeeklyForecastScreen extends StatelessWidget {
  const WeeklyForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: context.read<DataSource>().getWeeklyForcast(),
        builder: (context, snapShoot) => CustomScrollView(
          slivers: <Widget>[
            WeatherSliverAppBar(),
            if (snapShoot.hasData)
              WeeklyForecastList(weeklyForecast: snapShoot.data!)
            else if (snapShoot.hasError)
              _buildError(snapShoot, context)
            else
              _buildSpinner()
          ],
        ),
      ),
    );
  }

  SliverFillRemaining _buildSpinner() {
    return SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
  }

  SliverToBoxAdapter _buildError(AsyncSnapshot<WeeklyForcastDto> snapshoot, BuildContext context) {
    return SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  snapshoot.error.toString(),
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            );
  }
}
