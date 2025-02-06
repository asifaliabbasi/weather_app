import 'package:flutter/material.dart';
import '../mode/weather/weather_data_current.dart';
import '../utils/custom_colors.dart';

class CurrentWeatherWidget extends StatefulWidget {
  final WeatherDataCurrent weatherDataCurrent;


  const CurrentWeatherWidget({Key? key, required this.weatherDataCurrent})
      : super(key: key);

  @override
  State<CurrentWeatherWidget> createState() => _CurrentWeatherWidgetState();
}

class _CurrentWeatherWidgetState extends State<CurrentWeatherWidget> {

  bool _isTextVisible = true;
  void _toggleText() {
    setState(() {
      _isTextVisible = !_isTextVisible;
    });
  }

  Color color = Colors.black;


  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        //tempeture area
        tempeatureAreaWidget(),

        const SizedBox(
          height: 20,
        ),
        // more details - windspeed, humidity, clouds
        currentWeatherMoreDetailsWidget(),
      ],
    );
  }

  Widget currentWeatherMoreDetailsWidget() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: CustomColors.cardColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Image.asset("assets/icons/windspeed.png"),
            ),
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: CustomColors.cardColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Image.asset("assets/icons/clouds.png"),
            ),
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: CustomColors.cardColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Image.asset("assets/icons/humidity.png"),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                "${widget.weatherDataCurrent.current.windSpeed}km/h",
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                "${widget.weatherDataCurrent.current.clouds}%",
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                "${widget.weatherDataCurrent.current.humidity}%",
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            )
          ],
        )
      ],
    );
  }

  Widget tempeatureAreaWidget() {
    var cTemp = widget.weatherDataCurrent.current.temp!;
    var fTemp = widget.weatherDataCurrent.current.temp! * 5/9 + 32.toInt();

    if(cTemp > 30){
      color = Colors.redAccent;
    }
    else if(cTemp<10){
      color = Colors.blueAccent;
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            "assets/weather/${widget.weatherDataCurrent.current.weather![0].icon}.png",
            height: 80,
            width: 80,
          ),
          Container(
            height: 50,
            width: 2,
            color: CustomColors.dividerLine,
          ),
          SizedBox(width: 5,),
      
          RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: _isTextVisible ? '${cTemp}c°' : '${fTemp.round()}f°',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 68,
                    color: color,
                  )),
              TextSpan(
                  text: "${widget.weatherDataCurrent.current.weather![0].description}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.grey,
                  )),
            ]),
          ),
          SizedBox(width: 20,),
          InkWell(
              onTap: (){
                _toggleText();
              },
              child: Icon(Icons.change_circle)),
        ],
      ),
    );
  }
}