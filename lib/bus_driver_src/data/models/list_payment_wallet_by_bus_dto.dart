import 'package:intl/intl.dart';

class ListPaymentWalletByBusDTO {
  bool? status;
  List<Description>? description;
  int? total;

  ListPaymentWalletByBusDTO({this.status, this.description, this.total});

  ListPaymentWalletByBusDTO.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'];
    if (json['description'] != null) {
      description = <Description>[];
      json['description'].forEach((v) {
        description!.add(new Description.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.description != null) {
      data['description'] = this.description!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

class Description {
  String? id;
  String? userName;
  String? name;
  String? value;
  String? date;
  String? tripID;
  String? routeID;
  String? routeName;
  String? busID;
  String? palteNumber;

  Description(
      {this.id,
        this.userName,
        this.name,
        this.value,
        this.date,
        this.tripID,
        this.routeID,
        this.routeName,
        this.busID,
        this.palteNumber});

  Description.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    name = json['name'];
    value = json['value'];
    date = json['date'];
    tripID = json['tripID'];
    routeID = json['routeID'];
    routeName = json['routeName'];
    busID = json['busID'];
    palteNumber = json['palteNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['name'] = this.name;
    data['value'] = this.value;
    data['date'] = this.date;
    data['tripID'] = this.tripID;
    data['routeID'] = this.routeID;
    data['routeName'] = this.routeName;
    data['busID'] = this.busID;
    data['palteNumber'] = this.palteNumber;
    return data;
  }

  String get time => '${DateFormat('M/d/yyyy hh:mm:ss aa').format(DateTime.parse(date!))}';
}