class UserProfileDTO {
  bool? status;
  ProfileInformation? profileInformation;

  UserProfileDTO({this.status, this.profileInformation});

  UserProfileDTO.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'];
    profileInformation = json['description'] != null ? new ProfileInformation.fromJson(json['description']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.profileInformation != null) {
      data['description'] = this.profileInformation!.toJson();
    }
    return data;
  }
}

class ProfileInformation {
  String? userName;
  Null? phone;
  String? name;
  String? email;
  Null? image;

  ProfileInformation({this.userName, this.phone, this.name, this.email, this.image});

  ProfileInformation.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    phone = json['phone'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['phone'] = this.phone;
    data['name'] = this.name;
    data['email'] = this.email;
    data['image'] = this.image;
    return data;
  }
}