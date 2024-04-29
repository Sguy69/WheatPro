import 'package:flutter_application_1/src/model/coord.dart';
import 'package:flutter_application_1/src/model/main_weather.dart';
import 'package:flutter_application_1/src/model/sys.dart';
import 'package:flutter_application_1/src/model/weather.dart';
import 'package:flutter_application_1/src/model/wind.dart';

class CurrentWeatherData{
  final Coord coord;
  final List<Weather> weather;
  final Main main;
  final int visibility;
  final Wind wind;
  final Sys sys;
  final int timezone;
  final String name;
  final int id;


  CurrentWeatherData({
    required this.coord,
    required this.weather,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.sys,
    required this.timezone,
    required this.name,
    required this.id,
  });

  factory CurrentWeatherData.fromJson(Map<String, dynamic> json) {
    var weatherList = json['weather'] as List;
    List<Weather> weather = weatherList.map((i) => Weather.fromJson(i)).toList();
    return CurrentWeatherData(
      coord: Coord.fromJson(json['coord']),
      weather: weather,
      main: Main.fromJson(json['main']),
      visibility: json['visibility'],
      wind: Wind.fromJson(json['wind']),
      sys: Sys.fromJson(json['sys']),
      timezone: json['timezone'],
      name: json['name'],
      id: json['id'],
    );
  }
}