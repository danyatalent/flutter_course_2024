import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practice_1/features/core/data/osm/models/osm_weather.dart';

class OSMApi {
  final String url = 'https://api.openweathermap.org';
  final String apiKey;

  OSMApi(this.apiKey);

  Future<OSMWeather> getWeatherByCity(String city) async {
    var response = await http.get(Uri.parse('$url/data/2.5/weather?q=$city&appid=$apiKey'));
    var rJson = jsonDecode(response.body);

    return OSMWeather(rJson['main']['temp'], rJson['weather'][0]['main']);
  }

  Future<OSMWeather> getWeatherByCords(double latitude, double longitude) async {
    var response = await http.get(Uri.parse('$url/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey'));
    var rJson = jsonDecode(response.body);

    return OSMWeather(rJson['current']['temp'], rJson['current']['weather'][0]['main']);
  }
}