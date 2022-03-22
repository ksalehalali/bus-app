class RouteData {
  RouteData({
    required this.busId,
    required this.routeId
  });

  RouteData.fromJson(Map<String, dynamic> json) {
    busId = json['busId'];
    routeId = json['routeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['busId'] = this.busId;
    data['routeId'] = this.routeId;
    return data;
  }

  String? busId;
  String? routeId;
}