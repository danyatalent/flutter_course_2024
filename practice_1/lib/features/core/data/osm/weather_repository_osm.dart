import 'package:practice_1/features/core/data/osm/osm_api.dart';
import 'package:practice_1/features/core/domain/entities/search_query.dart';
import 'package:practice_1/features/core/domain/entities/search_response.dart';
import 'package:practice_1/features/core/domain/repositories/weather_repository.dart';

class WeatherRepositoryOSM implements WeatherRepository {
  final OSMApi _api;

  WeatherRepositoryOSM(this._api);

  @override
  Future<SearchResponse> getWeather(SearchQuery query) async {
    if (query is SearchQueryCity) {
      var response = await _api.getWeatherByCity(query.city);
      return SearchResponse(response.temp.toInt() - 273, _weatherType(response.type));
    } else if (query is SearchQueryCords) {
      var response = await _api.getWeatherByCords(query.latitude, query.longitude);
      return SearchResponse(response.temp.toInt() - 273, _weatherType(response.type));
    }

    throw ArgumentError('Некорректный тип');
  }
}

WeatherType _weatherType(String type) {
  switch (type) {
    case 'Clouds':
      return WeatherType.cloudy;
    case 'Clear':
      return WeatherType.clear;
    case 'Rain':
      return WeatherType.rain;
    default:
      return WeatherType.other;
  }
}