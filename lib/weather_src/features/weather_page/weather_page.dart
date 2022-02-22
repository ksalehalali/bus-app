import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import 'current_weather.dart';
import 'hourly_weather.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key, required this.city}) : super(key: key);
  final String city;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.rainGradient,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacer(),
              CurrentWeather(city: city),
              const Spacer(),
              HourlyWeather(city: city),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
