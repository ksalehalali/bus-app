class DriverOutCredentials {
  String? BusID;

  DriverOutCredentials({this.BusID});

  DriverOutCredentials.fromJson(Map<dynamic, dynamic> json) {
    BusID = json['BusID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BusID'] = this.BusID;
    return data;
  }
}