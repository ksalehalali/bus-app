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

  Future<bool?> clearSharedPreferencesData(SharedPreferences sharedPreferences) async{
    return await sharedPreferences.clear();
  }

  String? getAccessToken(SharedPreferences sharedPreferences) {
    return sharedPreferences.getString(SharedPreferencesConstants().accessTokenKey);
  }

  Future<bool?> setAccessToken(SharedPreferences? sharedPreferences, String? value) async{
    return await sharedPreferences!.setString(SharedPreferencesConstants().accessTokenKey, value!);
  }

  Future<bool?> removeAccessToken(SharedPreferences sharedPreferences) async{
     return await sharedPreferences.remove('counter');
  }
}