import 'package:intl/intl.dart';

class UserIncomingWalletDTO {
  bool? status;
  List<IncomingWalletItem>? incomingWalletItem;
  int? total;

  UserIncomingWalletDTO({this.status, this.incomingWalletItem, this.total});

  UserIncomingWalletDTO.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'];
    if (json['description'] != null) {
      incomingWalletItem = <IncomingWalletItem>[];
      json['description'].forEach((v) {
        incomingWalletItem!.add(new IncomingWalletItem.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.incomingWalletItem != null) {
      data['description'] = this.incomingWalletItem!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

class IncomingWalletItem {
  String? id;
  String? userName;
  String? value;
  String? date;
  String? paymentGateway;
  int? invoiceId;

  IncomingWalletItem(
      {this.id,
        this.userName,
        this.value,
        this.date,
        this.paymentGateway,
        this.invoiceId});

  IncomingWalletItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    value = json['value'];
    date = json['date'];
    paymentGateway = json['paymentGateway'];
    invoiceId = json['invoiceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['value'] = this.value;
    data['date'] = this.date;
    data['paymentGateway'] = this.paymentGateway;
    data['invoiceId'] = this.invoiceId;
    return data;
  }

  String get time => '${DateFormat('M/d/yyyy hh:mm:ss aa').format(DateTime.parse(date!))}';
}