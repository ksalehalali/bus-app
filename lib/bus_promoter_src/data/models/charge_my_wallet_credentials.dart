class ChargeMyWalletCredentials {
  String? apiKey;
  String? apiSecret;
  double? invoiceValue;
  int? invoiceId;
  String? paymentGateway;

  ChargeMyWalletCredentials(
      {this.apiKey,
        this.apiSecret,
        this.invoiceValue,
        this.invoiceId,
        this.paymentGateway});

  ChargeMyWalletCredentials.fromJson(Map<String, dynamic> json) {
    apiKey = json['api_key'];
    apiSecret = json['api_secret'];
    invoiceValue = json['invoiceValue'];
    invoiceId = json['invoiceId'];
    paymentGateway = json['paymentGateway'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_key'] = this.apiKey;
    data['api_secret'] = this.apiSecret;
    data['invoiceValue'] = this.invoiceValue;
    data['invoiceId'] = this.invoiceId;
    data['paymentGateway'] = this.paymentGateway;
    return data;
  }
}