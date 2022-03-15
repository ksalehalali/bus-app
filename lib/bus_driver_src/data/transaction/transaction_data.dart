import 'package:bus_driver/bus_driver_src/data/transaction/transaction_type.dart';
import 'package:intl/intl.dart';

class Transaction {
  Transaction({
    required this.username,
    required this.createdTime,
    required this.status,
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

  final String? username;
  String? createdTime;
  final bool? status;

 // String get formattedTime => '${DateFormat('hh:mm:ss aa').format(DateTime.fromMillisecondsSinceEpoch(createdTime! * 1000))}';
  String get statusIconPath{
    if(status == true) return 'assets/icon/success.png'; else return 'assets/icon/failed.png' ;
  }
}