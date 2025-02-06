import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:weather_app/mode/weather/weather_data_current.dart';
import '../mode/weather/weather_data.dart';
import 'package:http/http.dart' as http;

import '../mode/weather/weather_data_daily.dart';
import '../mode/weather/weather_data_hourly.dart';
import '../utils/apiURL.dart';

class FetchWeatherAPI{
  WeatherData? weatherData;

  String date = DateFormat.yMMMd().format(DateTime.now());

  //data from response to json

Future<WeatherData> processData(lat,long)async{
  var response = await http.get(Uri.parse(apiURL(lat,long)));
  var jsonString = jsonDecode(response.body);
  weatherData = WeatherData(
      WeatherDataCurrent.fromJson(jsonString),
      WeatherDataHourly.fromJson(jsonString),
      WeatherDataDaily.fromJson(jsonString));
  return weatherData!;

}


}

