import 'package:practice_1/features/core/domain/entities/search_query.dart';
import 'package:practice_1/features/core/domain/repositories/weather_repository.dart';
import 'dart:io';

class App {
  final WeatherRepository repository;

  App(this.repository);

  void run() async {
    SearchQuery query;

    print('Выберите:\n'
        '1: Ввести город\n'
        '2: Ввести координаты');
    var type = stdin.readLineSync();

    switch (type){
      case '1':
        var city = stdin.readLineSync();
        if (city == null) {
          return;
        }

        query = SearchQueryCity(city);
        break;
      case '2':
        var latitude = stdin.readLineSync();
        var longitude = stdin.readLineSync();
        if (longitude == null || latitude == null) {
          return;
        }

        query = SearchQueryCords(double.parse(latitude), double.parse(longitude));
        break;
      default:
        print('Некорректный ввод. Пожалуйста, выберите 1 или 2');
        return;
    }

    try {
      var resp = await repository.getWeather(query);
      print('Погода: ${resp.temp} по Цельсию, тип: ${resp.type}');
    } catch (e) {
      print('Произошла ошибка: $e');
      return;
    }
  }
}