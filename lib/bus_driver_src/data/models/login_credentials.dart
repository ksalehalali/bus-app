class LoginCredentials {
  String? userName;
  String? password;

  LoginCredentials({this.userName, this.password});

  LoginCredentials.fromJson(Map<String, dynamic> json) {
    userName = json['UserName'];
    password = json['Password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserName'] = this.userName;
    data['Password'] = this.password;
    return data;
  }
}