import 'package:flutter/material.dart';

import 'weather_app.dart';

void main() {
  runApp(const WeatherApp());
}

//API ADRESS
//
//https://api.open-meteo.com/v1/forecast?latitude=55.4703&longitude=8.4519&hourly=temperature_2m&daily=weather_code,temperature_2m_max,temperature_2m_min&wind_speed_unit=ms&timezone=Europe%2FBerlin