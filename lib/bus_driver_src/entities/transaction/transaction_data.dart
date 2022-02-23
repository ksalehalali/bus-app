import 'package:bus_driver/bus_driver_src/entities/transaction/transaction_type.dart';
import 'package:intl/intl.dart';

class Transaction {
  Transaction({
    required this.username,
    required this.timestamp,
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
  int? timestamp;
  final String? status;

  String get formattedTime => '${DateFormat('hh:mm:ss aa').format(DateTime.fromMillisecondsSinceEpoch(timestamp! * 1000))}';
  String get statusIconPath{
    if(status == TransactionType.Success.name) return 'assets/icon/success.png'; else return 'assets/icon/failed.png' ;
  }
}