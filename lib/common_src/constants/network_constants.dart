class NetworkConstants{
  static final NetworkConstants _networkConstants = NetworkConstants._internal();

  factory NetworkConstants() {
    return _networkConstants;
  }

  NetworkConstants._internal();

  final baseUrl = "https://route.click68.com/api";
  final liveTransactionServerUrl = "https://route.click68.com/ChatHub";
  final headers = {"content-type" : "application/json", "accept" : "application/json"};
}