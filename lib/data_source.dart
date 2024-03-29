import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'models.dart';
import 'models/time_series.dart';

abstract class DataSource {
  Future<WeeklyForecastDto> getWeeklyForecast();

  Future<WeatherChartData> getChartData();

  Future<WeatherChartData> getChartDataHour(DateTime date);
}

class FakeDataSource implements DataSource {
  Future<WeeklyForecastDto> getWeeklyForecast() async {
    final json = await rootBundle.loadString("assets/weekly_forecast.json");
    return WeeklyForecastDto.fromJson(jsonDecode(json));
  }

  @override
  Future<WeatherChartData> getChartData() async {
    final json = await rootBundle.loadString("assets/chart_data.json");
    return WeatherChartData.fromJson(jsonDecode(json));
  }

  @override
  Future<WeatherChartData> getChartDataHour(DateTime date) async{
    final json = await rootBundle.loadString("assets/hourly_forecast.json");
    return WeatherChartData.fromJson(jsonDecode(json));
  }
}

class RealDataSource implements DataSource {
  var latitude = 55.4703;
  var longitude = 8.4519;

  @override
  Future<WeeklyForecastDto> getWeeklyForecast() async {
    try {
      final location = await Location.instance.getLocation();
      if (location.latitude != null) {
        this.latitude = location.latitude!;
        this.longitude = location.longitude!;
      }
    } catch (error){
      var latitude = 55.4703;
      var longitude = 8.4519;
    }

    final response = await http.get(Uri.parse("https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&daily=weather_code,temperature_2m_max,temperature_2m_min"));
    final json = response.body;
    return WeeklyForecastDto.fromJson(jsonDecode(json));
  }

  @override
  Future<WeatherChartData> getChartData() async {
    try {
      final location = await Location.instance.getLocation();
      if (location.latitude != null) {
        this.latitude = location.latitude!;
        this.longitude = location.longitude!;
      }
    } catch (error){
      var latitude = 55.4703;
      var longitude = 8.4519;
    }

    final response = await http.get(Uri.parse("https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&hourly=temperature_2m&daily=temperature_2m_max,temperature_2m_min"));
    return WeatherChartData.fromJson(jsonDecode(response.body));
  }

  @override
  Future<WeatherChartData> getChartDataHour(DateTime date) async {
    try {
      final location = await Location.instance.getLocation();
      if (location.latitude != null) {
        this.latitude = location.latitude!;
        this.longitude = location.longitude!;
      }
    } catch (error){
      var latitude = 55.4703;
      var longitude = 8.4519;
    }

    final startTime = date.toIso8601String().split("T")[0];
    final endTime = date.add(Duration(days: 1)).toIso8601String().split("T")[0];
    final response = await http.get(Uri.parse("https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&hourly=temperature_2m&start_date=$startTime&end_date=$endTime"));
    return WeatherChartData.fromJson(jsonDecode(response.body));
  }
}
