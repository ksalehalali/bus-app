class PaymentGatewaySuccessResponseDTO {
  int? invoiceId;
  String? invoiceStatus;
  String? invoiceReference;
  double? invoiceValue;

  PaymentGatewaySuccessResponseDTO(
      {this.invoiceId,
        this.invoiceStatus,
        this.invoiceReference,
        this.invoiceValue});

  PaymentGatewaySuccessResponseDTO.fromJson(Map<dynamic, dynamic> json) {
    invoiceId = json['InvoiceId'];
    invoiceStatus = json['InvoiceStatus'];
    invoiceReference = json['InvoiceReference'];
    invoiceValue = json['InvoiceValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['InvoiceId'] = this.invoiceId;
    data['InvoiceStatus'] = this.invoiceStatus;
    data['InvoiceReference'] = this.invoiceReference;
    data['InvoiceValue'] = this.invoiceValue;
    return data;
  }
}