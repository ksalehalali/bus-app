class NetworkConstants{
  static final NetworkConstants _networkConstants = NetworkConstants._internal();

  factory NetworkConstants() {
    return _networkConstants;
  }

  NetworkConstants._internal();

  final baseUrl = "https://route.click68.com/";
  final baseApiUrl = "https://route.click68.com/api";
  final api_key = r"$FhlF]3;.OIic&{>H;_DeW}|:wQ,A8";
  final api_secret = "Z~P7-_/i!=}?BIwAd*S67LBzUo4O^G";
  final liveTransactionServerUrl = "https://route.click68.com/ChatHub";
  final headers = {"content-type" : "application/json", "accept" : "application/json"};
}