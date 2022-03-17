
class RouteData {
  RouteData({
    required this.number,
    required this.startFrom,
    required this.endAt,
    required this.busPlateNumber,
    required this.busId,
    required this.routeId
  });


  RouteData.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    startFrom = json['startFrom'];
    endAt = json['endAt'];
    busPlateNumber = json['busPlateNumber'];
    busId = json['busId'];
    routeId = json['routeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['startFrom'] = this.startFrom;
    data['endAt'] = this.endAt;
    data['busPlateNumber'] = this.busPlateNumber;
    data['busId'] = this.busId;
    data['routeId'] = this.routeId;
    return data;
  }

  String? number;
  String? startFrom;
  String? endAt;
  String? busPlateNumber;
  String? busId;
  String? routeId;
}