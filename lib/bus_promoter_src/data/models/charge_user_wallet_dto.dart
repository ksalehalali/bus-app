class ChargeUserWalletDTO {
  bool? status;
  Description? description;

  ChargeUserWalletDTO({this.status, this.description});

  ChargeUserWalletDTO.fromJson(Map<dynamic, dynamic> json) {
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
  String? total;
  String? userName;
  String? userId;

  Description({this.total, this.userName, this.userId});

  Description.fromJson(Map<dynamic, dynamic> json) {
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