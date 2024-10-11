import 'package:practice_1/features/core/data/weatherapi/weather_api.dart';
import 'package:practice_1/features/core/domain/entities/search_query.dart';
import 'package:practice_1/features/core/domain/entities/search_response.dart';
import 'package:practice_1/features/core/domain/repositories/weather_repository.dart';

class WeatherAPIRepository implements WeatherRepository {
  final WeatherAPI _api;

  WeatherAPIRepository(this._api);

  @override
  Future<SearchResponse> getWeather(SearchQuery query) async {
    if (query is SearchQueryCity) {
      var response = await _api.getWeatherByCity(query.city);
      return SearchResponse(response.temp.toInt(), _weatherType(response.type));
    } else if (query is SearchQueryCords) {
      var response = await _api.getWeatherByCords(query.latitude, query.longitude);
      return SearchResponse(response.temp.toInt(), _weatherType(response.type));
    }

    throw ArgumentError('Некорректный тип');
  }

}

WeatherType _weatherType(String type) {
  switch (type) {
    case 'Partly Cloudy' || 'Cloudy':
      return WeatherType.cloudy;
    case 'Clear' || 'Sunny':
      return WeatherType.clear;
    case 'Rain' || 'Patchy rain nearby' || 'Light rain' || 'Moderate rain':
      return WeatherType.rain;
    default:
      return WeatherType.other;
  }
}