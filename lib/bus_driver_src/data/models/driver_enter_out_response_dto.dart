class DriverEnterOutResponseDTO {
  bool? status;
  Description? description;

  DriverEnterOutResponseDTO({this.status, this.description});

  DriverEnterOutResponseDTO.fromJson(Map<dynamic, dynamic> json) {
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
  String? message;
  bool? status;

  Description({this.message, this.status});

  Description.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}