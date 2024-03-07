import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/data_source.dart';

import 'weather_app.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      Provider<DataSource>(create: (context) => RealDataSource())
      //Provider<DataSource>(create: (context) => FakeDataSource())
    ],
    child: const WeatherApp(),
  /*
    Provider<DataSource>(
      create: (context) => RealDataSource(),
      child: const WeatherApp(),
    ),*/
    ),
  );
}

//API ADRESS
//
//https://api.open-meteo.com/v1/forecast?latitude=55.4703&longitude=8.4519&hourly=temperature_2m&daily=weather_code,temperature_2m_max,temperature_2m_min&wind_speed_unit=ms&timezone=Europe%2FBerlin
