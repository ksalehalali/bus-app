class SignalRTransactionDTO {
  String? clientMethod;
  List<Data>? data;

  SignalRTransactionDTO({this.clientMethod, this.data});

  SignalRTransactionDTO.fromJson(Map<String, dynamic> json) {
    clientMethod = json['ClientMethod'];
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClientMethod'] = this.clientMethod;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? userName;
  String? name;
  String? time;
  bool? status;

  Data({this.userName, this.name, this.time, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    name = json['name'];
    time = json['time'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['name'] = this.name;
    data['time'] = this.time;
    data['status'] = this.status;
    return data;
  }
}