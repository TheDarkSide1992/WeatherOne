import 'package:flutter/material.dart';
import 'package:weather/models.dart';
import 'chart_screen_hourly.dart';
import 'package:weather_icons/weather_icons.dart';
import 'server.dart';

class WeeklyForecastList extends StatelessWidget {
  final WeeklyForecastDto weeklyForecast;

  const WeeklyForecastList({super.key, required this.weeklyForecast});

  @override
  Widget build(BuildContext context) {
    final DateTime currentDate = DateTime.now();
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          //final DailyForecast dailyForecast = Server.getDailyForecastByID(index);
          String weekdayAsString(DateTime time) {
            return switch (time.weekday) {
              DateTime.monday => 'Monday',
              DateTime.tuesday => 'Tuesday',
              DateTime.wednesday => 'Wednesday',
              DateTime.thursday => 'Thursday',
              DateTime.friday => 'Friday',
              DateTime.saturday => 'Saturday',
              DateTime.sunday => 'Sunday',
              _ => ''
            };
          }
          final daily = weeklyForecast.daily!;
          final date = DateTime.parse(daily.time![index]);
          final weatherCode = WeatherCode.fromInt(daily.weatherCode![index]);
          final tempMax = daily.temperature2MMax![index];
          final tempMin = daily.temperature2MMin![index];

          return GestureDetector(
            //MaterialPageRoute(builder: (context) => ChartScreenHourly(date)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChartScreenHourly(date)),
              );
            },
            child: Card(
              child: Row(
                children: <Widget>[
                  SizedBox(
                    height: 200.0,
                    width: 200.0,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        DecoratedBox(
                          position: DecorationPosition.foreground,
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                              colors: <Color>[
                                Colors.grey[600]!,
                                Colors.transparent
                              ],
                            ),
                          ),
                          /*child: Image.network(
                            dailyForecast.imageId,
                            fit: BoxFit.cover,
                          ),*/
                          child:
                          BoxedIcon(
                            WeatherIcons.fromString(weatherCode.icon,
                                fallback: WeatherIcons.na),
                            size: 70,
                          ),
                        ),

                        Center(
                          child: Text(
                            "${date.day} / ${date.month}",
                            //dailyForecast.getDate(currentDate.day).toString(),
                            style: textTheme.displayMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            //dailyForecast.getWeekday(currentDate.weekday),
                            weekdayAsString(date),
                            style: textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 10.0),
                          Text("${weatherCode.description}"),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      '${tempMin} | ${tempMax} C',
                      //'${dailyForecast.highTemp} | ${dailyForecast.lowTemp} F',
                      style: textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        childCount: 7,
      ),
    );
  }
}
