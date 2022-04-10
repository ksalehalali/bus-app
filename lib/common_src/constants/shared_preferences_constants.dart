class SharedPreferencesConstants{
  static final SharedPreferencesConstants _sharedPreferencesConstants = SharedPreferencesConstants._internal();

  factory SharedPreferencesConstants() {
    return _sharedPreferencesConstants;
  }

  SharedPreferencesConstants._internal();

  final accountType = "account_type";
  final accessTokenKey = "access_token_key";
  final fcmToken = "fcm_token";
  final busId = "bus_id";
  final routeData = "route_data";
}