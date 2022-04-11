class PromoterOutgoingWalletCredentials {
  String? pageSize;
  String? pageNumber;

  PromoterOutgoingWalletCredentials({this.pageSize, this.pageNumber});

  PromoterOutgoingWalletCredentials.fromJson(Map<String, dynamic> json) {
    pageSize = json['PageSize'];
    pageNumber = json['PageNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PageSize'] = this.pageSize;
    data['PageNumber'] = this.pageNumber;
    return data;
  }
}