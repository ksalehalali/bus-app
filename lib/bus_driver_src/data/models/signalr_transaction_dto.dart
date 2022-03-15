class SignalRTransactionDTO {
  String? userName;
  String? name;
  String? time;
  bool? status;

  SignalRTransactionDTO({this.userName, this.name, this.time, this.status});

  SignalRTransactionDTO.fromJson(Map<String, dynamic> json) {
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