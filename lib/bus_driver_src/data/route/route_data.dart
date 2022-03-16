
class RouteData {
  RouteData({
    required this.number,
    required this.startFrom,
    required this.endAt,
    required this.busPlateNumber,
    required this.busId
  });


  RouteData.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    startFrom = json['startFrom'];
    endAt = json['endAt'];
    busPlateNumber = json['busPlateNumber'];
    busId = json['busId'];
  }


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

  String? number;
  String? startFrom;
  String? endAt;
  String? busPlateNumber;
  String? busId;
}