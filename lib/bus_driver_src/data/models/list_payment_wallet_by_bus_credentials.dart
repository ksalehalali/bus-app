class ListPaymentWalletByBusCredentials {
  String? id;
  int? pageNumber;
  int? pageSize;

  ListPaymentWalletByBusCredentials({this.id, this.pageNumber, this.pageSize});

  ListPaymentWalletByBusCredentials.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pageNumber = json['PageNumber'];
    pageSize = json['PageSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['PageNumber'] = this.pageNumber;
    data['PageSize'] = this.pageSize;
    return data;
  }
}