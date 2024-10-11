import 'dart:io';

import 'package:practice_1/features/core/data/weatherapi/repository.dart';
import 'package:practice_1/features/core/data/weatherapi/weather_api.dart';
import 'package:practice_1/features/core/presentation/app.dart';

const String version = '0.0.1';

void main(List<String> arguments) {

  var apiKey = Platform.environment['API_KEY'];

  if (apiKey == null) {
    print('API_KEY не задан.');
    return;
  }

  // var api = OSMApi(apiKey);
  // var app = App(WeatherRepositoryOSM(api2));

  var api = WeatherAPI(apiKey);
  var app = App(WeatherAPIRepository(api));

  app.run();
}
