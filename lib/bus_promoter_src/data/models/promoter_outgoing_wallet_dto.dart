import 'package:intl/intl.dart';

class PromoterOutgoingWalletDTO {
  bool? status;
  List<OutgoingWalletItem>? outgoingWalletItems;

  PromoterOutgoingWalletDTO({this.status, this.outgoingWalletItems});

  PromoterOutgoingWalletDTO.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'];
    if (json['description'] != null) {
      outgoingWalletItems = <OutgoingWalletItem>[];
      json['description'].forEach((v) {
        outgoingWalletItems!.add(new OutgoingWalletItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.outgoingWalletItems != null) {
      data['description'] = this.outgoingWalletItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OutgoingWalletItem {
  String? id;
  String? paymentDate;
  String? value;
  String? promoter;
  String? user;

  OutgoingWalletItem(
      {this.id, this.paymentDate, this.value, this.promoter, this.user});

  OutgoingWalletItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentDate = json['payment_Date'];
    value = json['value'];
    promoter = json['promoter'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['payment_Date'] = this.paymentDate;
    data['value'] = this.value;
    data['promoter'] = this.promoter;
    data['user'] = this.user;
    return data;
  }
  String get time => '${DateFormat('M/d/yyyy hh:mm:ss aa').format(DateTime.parse(paymentDate!))}';
}