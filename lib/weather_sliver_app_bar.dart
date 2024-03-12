import 'package:flutter/material.dart';
import 'chart_screen_week.dart';
import 'server.dart';

class WeatherSliverAppBar extends StatelessWidget {
  const WeatherSliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      stretch: true,
      onStretchTrigger: () async {
        print('Load new data!');
        // await Server.requestNewData();
      },
      expandedHeight: 275.0,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [
          StretchMode.zoomBackground,
          StretchMode.fadeTitle,
          StretchMode.blurBackground,
        ],
        title: const Text('Noice_Weather.dk'),
        background: DecoratedBox(
          position: DecorationPosition.foreground,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.center,
              colors: <Color>[Colors.purple[800]!, Colors.transparent],
            ),
          ),/*
          child: Column( children: [
            ChartScreenDaily(),
            Container(height: 25, color: Colors.transparent),
          ]),*/
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: ChartScreenDaily(),
          ),
        ),
      ),
    );
  }
}
