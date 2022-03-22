import 'package:bus_driver/bus_driver_src/data/route/route_data.dart';
import 'package:bus_driver/bus_driver_src/features/home_page/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'bus_driver_src/features/login/login_page.dart';
import 'bus_driver_src/helper/shared_preferences.dart';
import 'bus_driver_src/data/route/route_data.dart';
import 'bus_driver_src/services/push_notification_service.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //await PushNotificationService().setupInteractedMessage();

  AppData _appData = AppData();
  await _appData.getSharedPreferencesInstance().then((pref){
    String? busId = _appData.getBusID(pref!);
    if(busId == null) runApp(const ProviderScope(child: MyApp(true)));
    else runApp(const ProviderScope(child: MyApp(false)));
  });

/*
  RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    //1- App received a notification when it was killed
    print("1- FCM Notification: initialMessage: ${initialMessage}");
  }
  */

}
class MyApp extends StatelessWidget {
  const MyApp(this.isLogin, {Key? key}) : super(key: key);
  final bool isLogin;

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
      home: _getNextPage(),
    );
  }

  Widget _getNextPage() {
    if(isLogin == true){
      return LoginPage();
    } else {
     // RouteData dummyRouteData = RouteData(number: 'Dummy-103', startFrom: 'Jahra', endAt: 'Maliya', busPlateNumber: '11-47463', busId: '255ac1a2-1921-463a-de86-08da0015b60c', routeId: '34addb01-2b86-49f2-13a8-08d9d82ee213');
      return HomePage();
    }
  }
}
