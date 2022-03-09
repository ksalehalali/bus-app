class DescriptionDTO {
  String? token;
  String? type;
  String? userName;
  String? id;
  Null? email;
  String? phoneNumber;
  List<String>? role;
  int? accessFailed;

  DescriptionDTO(
      {this.token,
      this.type,
      this.userName,
      this.id,
      this.email,
      this.phoneNumber,
      this.role,
      this.accessFailed});

  DescriptionDTO.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    type = json['type'];
    userName = json['userName'];
    id = json['id'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    role = json['role'].cast<String>();
    accessFailed = json['accessFailed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['type'] = this.type;
    data['userName'] = this.userName;
    data['id'] = this.id;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['role'] = this.role;
    data['accessFailed'] = this.accessFailed;
    return data;
  }
}
