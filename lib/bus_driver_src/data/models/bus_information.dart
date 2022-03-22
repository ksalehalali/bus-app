class BusInformation {
  bool? status;
  Description? description;

  BusInformation({this.status, this.description});

  BusInformation.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    description = json['description'] != null ? new Description.fromJson(json['description']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.description != null) {
      data['description'] = this.description!.toJson();
    }
    return data;
  }
}

class Description {
  String? id;
  String? company;
  ApplicationRoute? applicationRoute;
  String? routeID;
  String? palteNumber;
  String? kind;
  dynamic? applicationDriver;
  String? driverID;
  bool? active;

  Description(
      {this.id,
        this.company,
        this.applicationRoute,
        this.routeID,
        this.palteNumber,
        this.kind,
        this.applicationDriver,
        this.driverID,
        this.active});

  Description.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    company = json['company'];
    applicationRoute = json['applicationRoute'] != null ? new ApplicationRoute.fromJson(json['applicationRoute']) : null;
    routeID = json['routeID'];
    palteNumber = json['palteNumber'];
    kind = json['kind'];
    applicationDriver = json['applicationDriver'];
    driverID = json['driverID'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company'] = this.company;
    if (this.applicationRoute != null) {
      data['applicationRoute'] = this.applicationRoute!.toJson();
    }
    data['routeID'] = this.routeID;
    data['palteNumber'] = this.palteNumber;
    data['kind'] = this.kind;
    data['applicationDriver'] = this.applicationDriver;
    data['driverID'] = this.driverID;
    data['active'] = this.active;
    return data;
  }
}

class ApplicationRoute {
  String? id;
  String? nameEN;
  String? nameAR;
  String? fromToEN;
  String? fromToAR;
  String? areaEN;
  String? areaAR;
  String? company;
  int? price;

  ApplicationRoute(
      {this.id,
        this.nameEN,
        this.nameAR,
        this.fromToEN,
        this.fromToAR,
        this.areaEN,
        this.areaAR,
        this.company,
        this.price});

  ApplicationRoute.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEN = json['name_EN'];
    nameAR = json['name_AR'];
    fromToEN = json['from_To_EN'];
    fromToAR = json['from_To_AR'];
    areaEN = json['area_EN'];
    areaAR = json['area_AR'];
    company = json['company'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_EN'] = this.nameEN;
    data['name_AR'] = this.nameAR;
    data['from_To_EN'] = this.fromToEN;
    data['from_To_AR'] = this.fromToAR;
    data['area_EN'] = this.areaEN;
    data['area_AR'] = this.areaAR;
    data['company'] = this.company;
    data['price'] = this.price;
    return data;
  }
}
