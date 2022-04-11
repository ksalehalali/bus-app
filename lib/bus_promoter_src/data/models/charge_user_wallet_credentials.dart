class ChargeUserWalletCredentials {
  String? apiKey;
  String? apiSecret;
  String? userID;
  String? promoterID;
  double? invoiceValue;

  ChargeUserWalletCredentials(
      {this.apiKey,
        this.apiSecret,
        this.userID,
        this.promoterID,
        this.invoiceValue});

  ChargeUserWalletCredentials.fromJson(Map<String, dynamic> json) {
    apiKey = json['api_key'];
    apiSecret = json['api_secret'];
    userID = json['UserID'];
    promoterID = json['PromoterID'];
    invoiceValue = json['invoiceValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_key'] = this.apiKey;
    data['api_secret'] = this.apiSecret;
    data['UserID'] = this.userID;
    data['PromoterID'] = this.promoterID;
    data['invoiceValue'] = this.invoiceValue;
    return data;
  }
}