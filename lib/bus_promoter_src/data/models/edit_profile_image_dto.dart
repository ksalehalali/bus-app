class EditProfileImageDTO {
  bool? status;
  String? description;

  EditProfileImageDTO({this.status, this.description});

  EditProfileImageDTO.fromJson(Map<dynamic, dynamic> json) {
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