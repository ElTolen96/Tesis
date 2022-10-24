class EnvioVentaModel {
  EnvioVentaModel({
    required this.amount,
    required this.currencyCode,
    required this.email,
    required this.sourceId,
  });

  String amount;
  String currencyCode;
  String email;
  String sourceId;

  factory EnvioVentaModel.fromJson(Map<String, dynamic> json) => EnvioVentaModel(
    amount: json["amount"],
    currencyCode: json["currency_code"],
    email: json["email"],
    sourceId: json["source_id"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "currency_code": currencyCode,
    "email": email,
    "source_id": sourceId,
  };
}
