import 'package:weather_app/Api/ApiKey.dart';

String apiURL(lat,lon){
  String url;
  url = 'https://api.openweathermap.org/data/3.0/onecall?lat=${lat}&lon=${lon}&units=metric&exclude={part}&appid=$apiKey';
  return url;
}
