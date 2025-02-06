import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/Api/featch_Weather.dart';
import 'package:weather_app/Api/fetchCoordinates.dart';
import 'package:flutter/material.dart';
import '../mode/weather/weather_data.dart';
import '../widgets/dailogue.dart';

class GlobalController extends GetxController {
  // Create various variables
  late String city;
  late String province;
  final RxBool _isLoading = false.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxInt _currentIndex = 0.obs;

  // Instance for them to be called
  RxBool checkLoading() => _isLoading;
  RxDouble getLatitude() => _latitude;
  RxDouble getLongitude() => _longitude;

  final weatherData = WeatherData().obs;
  WeatherData getData() => weatherData.value;

  // Get coordinates from city name
  Future<void> getnewCoordinates(String cityName, BuildContext context) async {
    try {
      final coordinates = await getCoordinates(cityName);
      print('Latitude: ${coordinates.lat}, Longitude: ${coordinates.lon}, Display Name: ${coordinates.displayName}');

      FetchWeatherAPI().processData(coordinates.lat, coordinates.lon).then((value) {
        _isLoading.value = false;
        weatherData.value = value;
        print('The data is ${value.toString()}');
      });

    } catch (e) {
      Dailogs.showSnackbar(context, 'No City Found! Please Check Spelling');
      print('Error: $e');
    }
  }

  @override
  void onInit() {
    if (_isLoading.isTrue) {
      getLocation();
    }
    super.onInit();
  }

  // Get the current location
  Future<void> getLocation() async {
    try {
      bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isServiceEnabled) {
        throw 'Location not enabled';
      }

      LocationPermission locationPermission = await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.deniedForever) {
        throw 'Location permission is denied forever';
      } else if (locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
        if (locationPermission == LocationPermission.denied) {
          throw 'Location permission is denied';
        }
      }

      Position position = await Geolocator.getCurrentPosition(
          locationSettings: LocationSettings(accuracy: LocationAccuracy.high));
      _latitude.value = position.latitude;
      _longitude.value = position.longitude;
      _isLoading.value = false;

      FetchWeatherAPI().processData(_latitude.value, _longitude.value).then((value) {
        _isLoading.value = false;
        weatherData.value = value;
        print('The data is ${value.toString()}');
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  RxInt getIndex() => _currentIndex;
}
