import 'dart:convert';
import 'package:http/http.dart' as http;

class Coordinates {
  String? lat;
  String? lon;
  String? displayName;

  Coordinates({this.lat, this.lon, this.displayName});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      lat: json['lat'],
      lon: json['lon'],
      displayName: json['display_name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['display_name'] = this.displayName;
    return data;
  }
}

Future<Coordinates> getCoordinates(String cityName) async {
  final url = Uri.parse('https://geocode.maps.co/search?q=$cityName&api_key=67a350f6660e4365956645pow45c6c7');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> responseBody = json.decode(response.body);

    if (responseBody.isNotEmpty) {
      return Coordinates.fromJson(responseBody[0]);
    } else {
      throw Exception('No coordinates found for the given city name.');
    }
  } else {
    throw Exception('Failed to load coordinates.');
  }
}
