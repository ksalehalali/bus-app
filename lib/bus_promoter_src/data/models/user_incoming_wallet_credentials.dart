class UserIncomingWalletCredentials {
  int? pageNumber;
  int? pageSize;

  UserIncomingWalletCredentials({this.pageNumber, this.pageSize});

  UserIncomingWalletCredentials.fromJson(Map<String, dynamic> json) {
    pageNumber = json['PageNumber'];
    pageSize = json['PageSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PageNumber'] = this.pageNumber;
    data['PageSize'] = this.pageSize;
    return data;
  }
}