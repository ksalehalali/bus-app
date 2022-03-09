import 'package:bus_driver/bus_driver_src/data/route/route_data.dart';
import 'package:bus_driver/bus_driver_src/features/home_page/home_page.dart';
import 'package:bus_driver/bus_driver_src/features/qrcode_scanner/scanner.dart';
import 'package:bus_driver/weather_src/features/weather_page/weather_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bus_driver_src/features/login/login_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyleWithShadow = TextStyle(color: Colors.white, shadows: [BoxShadow(color: Colors.black12.withOpacity(0.25), spreadRadius: 1, blurRadius: 4, offset: const Offset(0, 0.5),)]);
    return MaterialApp(
      title: 'Bus Driver App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: TextTheme(
          headline1: textStyleWithShadow,
          headline2: textStyleWithShadow,
          headline3: textStyleWithShadow,
          headline4: textStyleWithShadow,
          headline5: textStyleWithShadow,
         // titleSmall: const TextStyle(color: Colors.white, fontSize: 12),
          subtitle1: const TextStyle(color: Colors.white),
          bodyText2: const TextStyle(color: Colors.white),
          bodyText1: const TextStyle(color: Colors.white),
          caption: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
      ),
      home:
      //HomePage(routeData: RouteData(number: 999, startFrom: 'Maliya', endAt: 'Fahaheel', busPlateNumber: '11-25034')),
     // Scanner(),
      LoginPage(),
    );
  }
}
