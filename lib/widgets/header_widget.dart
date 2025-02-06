import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../controller/global_controller.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});
  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  bool _isSearch = false;
  TextEditingController cityname = TextEditingController();
  String city = "";
  String date = DateFormat("yMMMMd").format(DateTime.now());
  IconData icon = Icons.search;

  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  void initState() {
    getAddress(globalController.getLatitude().value,
        globalController.getLongitude().value);
    super.initState();
  }

  getAddress(lat, lon) async {
    List<Placemark> placemark = await placemarkFromCoordinates(lat, lon);
    Placemark place = placemark[0];
    setState(() {
      city = place.locality!.toUpperCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Container(
            height: 50,
            child: TextField(controller: cityname,

                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.location_pin,color: Colors.greenAccent,),
                  hintText: 'Search your city',
                    suffixIcon: InkWell(
                        onTap: (){
                          if(cityname.text.isNotEmpty && icon == Icons.search) {
                            globalController.getnewCoordinates(
                                cityname.text, context);
                            setState(() {
                              print(cityname.text);
                              _isSearch = true;
                              icon = Icons.cancel;
                            });
                          }
                          else if(icon == Icons.cancel){
                            cityname.clear();
                            icon = Icons.search;
                            setState(() {
                              globalController.update();
                              globalController.getLocation();
                            });
                          }

                          },
                        child: Icon(icon)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))
                        ) ,
                        enabledBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    )
                )
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.topLeft,
          child: Text(
            cityname.text.isEmpty?
            city:cityname.text.toUpperCase(),
            style: const TextStyle(fontSize: 30, height: 2, fontFamily: 'common', fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          alignment: Alignment.topLeft,
          child: Text(
            date,
            style:
                TextStyle(fontSize: 14, color: Colors.grey[700], height: 1.5),
          ),
        ),
      ],
    );
  }
}
