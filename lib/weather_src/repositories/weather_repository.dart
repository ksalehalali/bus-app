import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../api/api.dart';
import '../api/api_keys.dart';
import '../entities/forecast/forecast.dart';
import '../entities/weather/weather.dart';
import 'api_error.dart';

/// Weather Repository using the http client. Calls API methods and parses responses.
class HttpWeatherRepository {
  HttpWeatherRepository({required this.api, required this.client});
  final OpenWeatherMapAPI api;
  final http.Client client;

  Future<Forecast> getForecast({required String city}) => _getData(uri: api.forecast(city), builder: (data) => Forecast.fromJson(data),);

  Future<Weather> getWeather({required String city}) => _getData(uri: api.weather(city), builder: (data) => Weather.fromJson(data),);

  Future<T> _getData<T>({required Uri uri, required T Function(dynamic data) builder,}) async {
    try {
      final response = await client.get(uri);
      switch (response.statusCode) {
        case 200:
          final data = json.decode(response.body);
          return builder(data);
        case 401:
          throw const APIError.invalidApiKey();
        default:
          throw const APIError.unknown();
      }
    } on SocketException catch (_) {
      throw const APIError.noInternetConnection();
    }
  }
}

/// Providers used by rest of the app
final weatherRepositoryProvider = Provider<HttpWeatherRepository>((ref) {
  /// Use the API key passed via --dart-define,
  /// or fallback to the one defined in api_keys.dart
  final apiKey = String.fromEnvironment('API_KEY', defaultValue: APIKeys.openWeatherAPIKey,);
  return HttpWeatherRepository(api: OpenWeatherMapAPI(apiKey), client: http.Client(),);
});
