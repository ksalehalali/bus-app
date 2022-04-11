class WalletDTO {
  bool? status;
  Wallet? wallet;

  WalletDTO({this.status, this.wallet});

  WalletDTO.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'];
    wallet = json['description'] != null ? new Wallet.fromJson(json['description']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.wallet != null) {
      data['description'] = this.wallet!.toJson();
    }
    return data;
  }
}

class Wallet {
  String? total;
  String? userName;
  String? userId;

  Wallet({this.total, this.userName, this.userId});

  Wallet.fromJson(Map<dynamic, dynamic> json) {
    total = json['total'];
    userName = json['userName'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['userName'] = this.userName;
    data['userId'] = this.userId;
    return data;
  }
}