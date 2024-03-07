import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'models.dart';


abstract class DataSource {
  Future<WeeklyForcastDto> getWeeklyForcast();
}

class FakeDataSource implements DataSource{
  Future<WeeklyForcastDto> getWeeklyForcast() async {
    final json = await rootBundle.loadString("assets/weekly_forcast.json");
    return WeeklyForcastDto.fromJson(jsonDecode(json));
  }
}

class RealDataSource implements DataSource{
  @override
  Future<WeeklyForcastDto> getWeeklyForcast() async {
    const url = "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&daily=weather_code,temperature_2m_max,temperature_2m_min&wind_speed_unit=ms&timezone=Europe%2FBerlin";
    final response = await http.get(Uri.parse(url));
    final json = response.body;
    return WeeklyForcastDto.fromJson(jsonDecode(json));
  }

}

