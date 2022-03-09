class SharedPreferencesConstants{
  static final SharedPreferencesConstants _sharedPreferencesConstants = SharedPreferencesConstants._internal();

  factory SharedPreferencesConstants() {
    return _sharedPreferencesConstants;
  }

  SharedPreferencesConstants._internal();

  final accessTokenKey = "access_token_key";
}