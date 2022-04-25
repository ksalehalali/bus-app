class ChargeMyWalletDTO {
  bool? status;
  SuccessDescription? successDescription = null;
  String? failedDescription = null;

  ChargeMyWalletDTO({this.status, this.successDescription});

  ChargeMyWalletDTO.fromSuccessJson(Map<dynamic, dynamic> json) {
    status = json['status'];
    successDescription = json['description'] != null ? new SuccessDescription.fromJson(json['description']) : null;
  }

  ChargeMyWalletDTO.fromFailedJson(Map<dynamic, dynamic> json) {
    status = json['status'];
    failedDescription = json['description'] != null ? json['description'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.successDescription != null) {
      data['description'] = this.successDescription!.toJson();
    }
    return data;
  }

  bool? isSuccess() => status;
}

class SuccessDescription {
  String? total;
  String? userName;
  String? userId;

  SuccessDescription({this.total, this.userName, this.userId});

  SuccessDescription.fromJson(Map<dynamic, dynamic> json) {
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