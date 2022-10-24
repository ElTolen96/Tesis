class VentaModel {
  VentaModel({
    required this.duplicated,
    required this.object,
    required this.id,
    required this.amount,
    required this.amountRefunded,
    required this.currentAmount,
    required this.installments,
    this.installmentsAmount,
    required this.currency,
    this.email,
    this.description,
    required this.source,
    this.fraudScore,
    required this.antifraudDetails,
    required this.date,
    required this.referenceCode,
    this.fee,
    required this.feeDetails,
    required this.netAmount,
    required this.responseCode,
    required this.merchantMessage,
    required this.userMessage,
    required this.deviceIp,
    this.deviceCountry,
    this.countryIp,
    required this.product,
    required this.state,
    this.metadata,
  });

  bool duplicated;
  String object;
  String id;
  int amount;
  int amountRefunded;
  int currentAmount;
  int installments;
  dynamic installmentsAmount;
  String currency;
  dynamic email;
  dynamic description;
  Source source;
  dynamic fraudScore;
  AntifraudDetails antifraudDetails;
  int date;
  String referenceCode;
  dynamic fee;
  List<FeeDetail> feeDetails;
  int netAmount;
  String responseCode;
  String merchantMessage;
  String userMessage;
  String deviceIp;
  dynamic deviceCountry;
  dynamic countryIp;
  String product;
  String state;
  dynamic metadata;

  factory VentaModel.fromJson(Map<String, dynamic> json) => VentaModel(
    duplicated: json["duplicated"],
    object: json["object"],
    id: json["id"],
    amount: json["amount"],
    amountRefunded: json["amount_refunded"],
    currentAmount: json["current_amount"],
    installments: json["installments"],
    installmentsAmount: json["installments_amount"],
    currency: json["currency"],
    email: json["email"],
    description: json["description"],
    source: Source.fromJson(json["source"]),
    fraudScore: json["fraud_score"],
    antifraudDetails: AntifraudDetails.fromJson(json["antifraud_details"]),
    date: json["date"],
    referenceCode: json["reference_code"],
    fee: json["fee"],
    feeDetails: List<FeeDetail>.from(json["fee_details"].map((x) => FeeDetail.fromJson(x))),
    netAmount: json["net_amount"],
    responseCode: json["response_code"],
    merchantMessage: json["merchant_message"],
    userMessage: json["user_message"],
    deviceIp: json["device_ip"],
    deviceCountry: json["device_country"],
    countryIp: json["country_ip"],
    product: json["product"],
    state: json["state"],
    metadata: json["metadata"],
  );

  Map<String, dynamic> toJson() => {
    "duplicated": duplicated,
    "object": object,
    "id": id,
    "amount": amount,
    "amount_refunded": amountRefunded,
    "current_amount": currentAmount,
    "installments": installments,
    "installments_amount": installmentsAmount,
    "currency": currency,
    "email": email,
    "description": description,
    "source": source.toJson(),
    "fraud_score": fraudScore,
    "antifraud_details": antifraudDetails.toJson(),
    "date": date,
    "reference_code": referenceCode,
    "fee": fee,
    "fee_details": List<dynamic>.from(feeDetails.map((x) => x.toJson())),
    "net_amount": netAmount,
    "response_code": responseCode,
    "merchant_message": merchantMessage,
    "user_message": userMessage,
    "device_ip": deviceIp,
    "device_country": deviceCountry,
    "country_ip": countryIp,
    "product": product,
    "state": state,
    "metadata": metadata,
  };
}

class AntifraudDetails {
  AntifraudDetails({
    this.countryCode,
    this.firstName,
    this.lastName,
    this.addressCity,
    this.address,
    required this.email,
    this.phone,
    required this.object,
  });

  dynamic countryCode;
  dynamic firstName;
  dynamic lastName;
  dynamic addressCity;
  dynamic address;
  String email;
  dynamic phone;
  String object;

  factory AntifraudDetails.fromJson(Map<String, dynamic> json) => AntifraudDetails(
    countryCode: json["country_code"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    addressCity: json["address_city"],
    address: json["address"],
    email: json["email"],
    phone: json["phone"],
    object: json["object"],
  );

  Map<String, dynamic> toJson() => {
    "country_code": countryCode,
    "first_name": firstName,
    "last_name": lastName,
    "address_city": addressCity,
    "address": address,
    "email": email,
    "phone": phone,
    "object": object,
  };
}

class FeeDetail {
  FeeDetail();

  factory FeeDetail.fromJson(Map<String, dynamic> json) => FeeDetail(
  );

  Map<String, dynamic> toJson() => {
  };
}

class Source {
  Source({
    required this.object,
    required this.id,
    required this.type,
    required this.creationDate,
    required this.cardNumber,
    required this.lastFour,
    required this.active,
    required this.iin,
    required this.client,
  });

  String object;
  String id;
  String type;
  int creationDate;
  String cardNumber;
  String lastFour;
  bool active;
  FeeDetail iin;
  FeeDetail client;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    object: json["object"],
    id: json["id"],
    type: json["type"],
    creationDate: json["creation_date"],
    cardNumber: json["card_number"],
    lastFour: json["last_four"],
    active: json["active"],
    iin: FeeDetail.fromJson(json["iin"]),
    client: FeeDetail.fromJson(json["client"]),
  );

  Map<String, dynamic> toJson() => {
    "object": object,
    "id": id,
    "type": type,
    "creation_date": creationDate,
    "card_number": cardNumber,
    "last_four": lastFour,
    "active": active,
    "iin": iin.toJson(),
    "client": client.toJson(),
  };
}
