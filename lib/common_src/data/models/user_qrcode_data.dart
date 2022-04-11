class UserQrCodeData {
  UserQrCodeData({
    required this.userId,
    required this.userName
  });

  UserQrCodeData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    return data;
  }

  String? userId;
  String? userName;
}