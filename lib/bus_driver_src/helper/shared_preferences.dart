import 'package:bus_driver/common_src/constants/shared_preferences_constants.dart';
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

  //AccountType
  String? getAccountType(SharedPreferences sharedPreferences) => sharedPreferences.getString(SharedPreferencesConstants().accountType);
  Future<bool?> setAccountType(SharedPreferences? sharedPreferences, String? accountType) async => await sharedPreferences!.setString(SharedPreferencesConstants().accountType, accountType!);
  Future<bool?> removeAccountType(SharedPreferences sharedPreferences) async => await sharedPreferences.remove(SharedPreferencesConstants().accountType);

  //userId
  String? getUserId(SharedPreferences sharedPreferences) => sharedPreferences.getString(SharedPreferencesConstants().userId);
  Future<bool?> setUserId(SharedPreferences? sharedPreferences, String? userId) async => await sharedPreferences!.setString(SharedPreferencesConstants().userId, userId!);
  Future<bool?> removeUserId(SharedPreferences sharedPreferences) async => await sharedPreferences.remove(SharedPreferencesConstants().userId);

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

  /*
  //Route Data
  String? getRouteData(SharedPreferences sharedPreferences) => sharedPreferences.getString(SharedPreferencesConstants().routeData);
  Future<bool?> setRouteData(SharedPreferences? sharedPreferences, String? routeData) async => await sharedPreferences!.setString(SharedPreferencesConstants().routeData, routeData!);
  Future<bool?> removeRouteData(SharedPreferences sharedPreferences) async => await sharedPreferences.remove(SharedPreferencesConstants().routeData);
  */
}