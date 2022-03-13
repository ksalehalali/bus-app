class LoginErrorResponseDTO {
  bool? status;


  LoginErrorResponseDTO({this.status});

  LoginErrorResponseDTO.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    return data;
  }
}