class DriverEnterCredentials {
  String? BusID;
  String? FCMToken;

  DriverEnterCredentials({this.BusID, this.FCMToken});

  DriverEnterCredentials.fromJson(Map<dynamic, dynamic> json) {
    BusID = json['BusID'];
    FCMToken = json['FCMToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BusID'] = this.BusID;
    data['FCMToken'] = this.FCMToken;
    return data;
  }
}