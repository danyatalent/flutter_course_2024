class WeatherAPIModel {
  final double temp;
  final String type;

  const WeatherAPIModel(this.temp, this.type);

  @override
  String toString() {
    return 'WeatherAPIModel{temp: $temp, type: $type}';
  }
}