import 'dart:convert';

import 'package:flutter/services.dart';

import 'models.dart';

class FakeDataSource {
  Future<WeeklyForcastDto> getWeeklyForcast() async {
    final json = await rootBundle.loadString("assets/weekly_forcast.json");
    return WeeklyForcastDto.fromJson(jsonDecode(json));
  }
}