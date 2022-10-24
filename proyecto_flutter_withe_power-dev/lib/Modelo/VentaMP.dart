class VentaMpModel {
  VentaMpModel({
    required this.idUsuario,
    required this.idTarjeta,
    required this.idZona,
    required this.monto,
    required this.codigoQr,
    required this.token,
    required this.idEvento,
    required this.entradas,
    required this.precioUnitario,
  });

  int idUsuario;
  int idTarjeta;
  int idZona;
  int monto;
  String codigoQr;
  String token;
  int idEvento;
  int entradas;
  int precioUnitario;

  factory VentaMpModel.fromJson(Map<String, dynamic> json) => VentaMpModel(
    idUsuario: json["IdUsuario"],
    idTarjeta: json["IdTarjeta"],
    idZona: json["IdZona"],
    monto: json["Monto"],
    codigoQr: json["CodigoQR"],
    token: json["Token"],
    idEvento: json["IdEvento"],
    entradas: json["Entradas"],
    precioUnitario: json["PrecioUnitario"],
  );

  Map<String, dynamic> toJson() => {
    "IdUsuario": idUsuario,
    "IdTarjeta": idTarjeta,
    "IdZona": idZona,
    "Monto": monto,
    "CodigoQR": codigoQr,
    "Token": token,
    "IdEvento": idEvento,
    "Entradas": entradas,
    "PrecioUnitario": precioUnitario,
  };
}
