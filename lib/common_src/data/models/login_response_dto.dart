import 'description_dto.dart';

class LoginResponseDTO {
  bool? status;
  DescriptionDTO? description;

  LoginResponseDTO({this.status, this.description});

  LoginResponseDTO.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'];
    description = json['description'] != null
        ? new DescriptionDTO.fromJson(json['description'])
        : null;
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