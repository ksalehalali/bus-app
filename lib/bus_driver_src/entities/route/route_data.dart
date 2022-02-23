
class RouteData {
  RouteData({
    required this.number,
    required this.startFrom,
    required this.endAt,
    required this.busPlateNumber,
  });

  /*
  factory WeatherData.from(Weather weather) {
    return WeatherData(
      temp: Temperature.celsius(weather.weatherParams.temp),
      minTemp: Temperature.celsius(weather.weatherParams.tempMin),
      maxTemp: Temperature.celsius(weather.weatherParams.tempMax),
      description: weather.weatherInfo[0].main,
      date: DateTime.fromMillisecondsSinceEpoch(weather.dt * 1000),
      icon: weather.weatherInfo[0].icon,
    );
  }
*/

  final int? number;
  final String? startFrom;
  final String? endAt;
  final String? busPlateNumber;
}