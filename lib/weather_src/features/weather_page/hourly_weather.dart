import 'package:bus_driver/weather_src/features/weather_page/weather_icon_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../weather_src/entities/weather/weather_data.dart';
import 'hourly_weather_controller.dart';

class HourlyWeather extends ConsumerWidget {
  const HourlyWeather({Key? key, required this.city}) : super(key: key);
  final String city;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forecastDataValue = ref.watch(hourlyWeatherControllerProvider(city));
    return forecastDataValue.when(data: (forecastData) {
        // API returns data points in 3-hour intervals -> 1 day = 8 intervals
        final items = [0, 8, 16, 24, 32];
        return HourlyWeatherRow(
          weatherDataItems: [
            for (var i in items) forecastData.list[i],
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, __) => Text(e.toString()),
    );
  }
}

class HourlyWeatherRow extends StatelessWidget {
  const HourlyWeatherRow({Key? key, required this.weatherDataItems}) : super(key: key);
  final List<WeatherData> weatherDataItems;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: weatherDataItems
          .map((data) => HourlyWeatherItem(data: data))
          .toList(),
    );
  }
}

class HourlyWeatherItem extends ConsumerWidget {
  const HourlyWeatherItem({Key? key, required this.data}) : super(key: key);
  final WeatherData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final fontWeight = FontWeight.normal;
    final temp = data.temp.celsius.toInt().toString();
    return Expanded(
      child: Column(
        children: [
          Text(DateFormat.E().format(data.date), style: textTheme.caption!.copyWith(fontWeight: fontWeight),),
          const SizedBox(height: 8),
          WeatherIconImage(iconUrl: data.iconUrl, size: 48),
          const SizedBox(height: 8),
          Text('$temp°', style: textTheme.bodyText1!.copyWith(fontWeight: fontWeight),),
        ],
      ),
    );
  }
}
