import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../entities/forecast/forecast_data.dart';
import '../../repositories/api_error.dart';
import '../../repositories/weather_repository.dart';

class HourlyWeatherController extends StateNotifier<AsyncValue<ForecastData>> {
  HourlyWeatherController(this._weatherRepository, {required String city}) : super(const AsyncValue.loading()) {
    getWeather(city: city);
  }
  final HttpWeatherRepository _weatherRepository;

  Future<void> getWeather({required String city}) async {
    try {
      state = const AsyncValue.loading();
      final forecast = await _weatherRepository.getForecast(city: city);
      state = AsyncValue.data(ForecastData.from(forecast));
    } on APIError catch (e) {
      state = e.asAsyncValue();
    }
  }
}

final hourlyWeatherControllerProvider = StateNotifierProvider.autoDispose
    .family<HourlyWeatherController, AsyncValue<ForecastData>, String>((ref, city) {
      final weatherRepository = ref.watch(weatherRepositoryProvider);
      return HourlyWeatherController(weatherRepository, city: city);
    });
