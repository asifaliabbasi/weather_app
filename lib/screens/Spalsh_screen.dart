import 'package:flutter/material.dart';
import 'package:weather_app/Api/featch_Weather.dart';
import 'package:weather_app/controller/global_controller.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
    FetchWeatherAPI().processData(GlobalController().getLatitude().value, GlobalController().getLongitude().value);
  }

  _navigateToHome() async {
    await Future.delayed(Duration(seconds: 5), () {});

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Your splash screen background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/clouds.png', // Replace with your logo/image path
              height: 200,
              width: 200,
            ),
            SizedBox(height: 20),
            Text(
              'Weather App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
