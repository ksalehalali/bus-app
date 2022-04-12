class EditProfileDTO {
  bool? status;
  String? description;

  EditProfileDTO({this.status, this.description});

  EditProfileDTO.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['description'] = this.description;
    return data;
  }
}