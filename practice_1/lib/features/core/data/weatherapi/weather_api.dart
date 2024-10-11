import 'dart:convert';

import 'package:practice_1/features/core/data/weatherapi/models/weather_api_models.dart';
import 'package:http/http.dart' as http;

class WeatherAPI {
  final String url = 'https://api.weatherapi.com/v1';
  final String apiKey;

  WeatherAPI(this.apiKey);

  Future<WeatherAPIModel> getWeatherByCity(String city) async {
    var response = await http.get(Uri.parse('$url/current.json?key=$apiKey&q=$city'));
    if (response.statusCode != 200) {
      throw Exception('Неверные ввод. Проверьте, что такой город/координаты существуют');
    }

    var rJson = jsonDecode(response.body);
    
    return WeatherAPIModel(rJson['current']['temp_c'], rJson['current']['condition']['text']);
  }

  Future<WeatherAPIModel> getWeatherByCords(double latitude, double longitude) async {
    var response = await http.get(Uri.parse('$url/current.json?key=$apiKey&q=$latitude,$longitude'));
    if (response.statusCode != 200) {
      throw Exception('Неверные ввод. Проверьте, что такой город/координаты существуют');
    }

    var rJson = jsonDecode(response.body);

    return WeatherAPIModel(rJson['current']['temp_c'], rJson['current']['condition']['text']);
  }
}