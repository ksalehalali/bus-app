import 'package:bus_driver/bus_driver_src/constants/shared_preferences_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppData{
  static final AppData _appData = AppData._internal();
  SharedPreferences? prefs;

  factory AppData() {
    return _appData;
  }

  AppData._internal();

  Future<SharedPreferences?> getSharedPreferencesInstance() async{
    if (prefs == null) await SharedPreferences.getInstance().then((value) => prefs = value);
    return prefs;
  }

  Future<bool?> clearSharedPreferencesData(SharedPreferences sharedPreferences) async => await sharedPreferences.clear();

  //AccessToken
  String? getAccessToken(SharedPreferences sharedPreferences) => 'bearer ${sharedPreferences.getString(SharedPreferencesConstants().accessTokenKey)}';
  Future<bool?> setAccessToken(SharedPreferences? sharedPreferences, String? accessToken) async => await sharedPreferences!.setString(SharedPreferencesConstants().accessTokenKey, accessToken!);
  Future<bool?> removeAccessToken(SharedPreferences sharedPreferences) async => await sharedPreferences.remove(SharedPreferencesConstants().accessTokenKey);

  //FcmToken
  String? getFcmToken(SharedPreferences sharedPreferences) => sharedPreferences.getString(SharedPreferencesConstants().fcmToken);
  Future<bool?> setFcmToken(SharedPreferences? sharedPreferences, String? fcmToken) async => await sharedPreferences!.setString(SharedPreferencesConstants().fcmToken, fcmToken!);
  Future<bool?> removeFcmToken(SharedPreferences sharedPreferences) async => await sharedPreferences.remove(SharedPreferencesConstants().fcmToken);

  //BusID
  String? getBusID(SharedPreferences sharedPreferences) => sharedPreferences.getString(SharedPreferencesConstants().busId);
  Future<bool?> setBusID(SharedPreferences? sharedPreferences, String? busId) async => await sharedPreferences!.setString(SharedPreferencesConstants().busId, busId!);
  Future<bool?> removeBusID(SharedPreferences sharedPreferences) async => await sharedPreferences.remove(SharedPreferencesConstants().busId);
}