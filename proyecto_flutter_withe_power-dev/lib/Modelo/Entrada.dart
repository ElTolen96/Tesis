class EntradaModel {
  EntradaModel({
    required this.idVenta,
    required this.idUsuario,
    required this.idTarjeta,
    required this.idZona,
    required this.fechaVenta,
    required this.monto,
    required this.codigoQr,
    required this.token,
    required this.flag,
    required this.activo,
    required this.nombres,
    required this.apellidos,
    required this.zona,
    required this.numeroEntradas,
    required this.precioUnitario,
  });

  String idVenta;
  String idUsuario;
  String idTarjeta;
  String idZona;
  DateTime fechaVenta;
  String monto;
  String codigoQr;
  String token;
  String flag;
  String activo;
  String nombres;
  String apellidos;
  String zona;
  String numeroEntradas;
  String precioUnitario;

  factory EntradaModel.fromJson(Map<String, dynamic> json) => EntradaModel(
    idVenta: json["IdVenta"],
    idUsuario: json["IdUsuario"],
    idTarjeta: json["IdTarjeta"],
    idZona: json["IdZona"],
    fechaVenta: DateTime.parse(json["FechaVenta"]),
    monto: json["Monto"],
    codigoQr: json["CodigoQR"],
    token: json["Token"],
    flag: json["Flag"],
    activo: json["Activo"],
    nombres: json["Nombres"],
    apellidos: json["Apellidos"],
    zona: json["Zona"],
    numeroEntradas: json["NumeroEntradas"],
    precioUnitario: json["PrecioUnitario"],
  );

  Map<String, dynamic> toJson() => {
    "IdVenta": idVenta,
    "IdUsuario": idUsuario,
    "IdTarjeta": idTarjeta,
    "IdZona": idZona,
    "FechaVenta": fechaVenta.toIso8601String(),
    "Monto": monto,
    "CodigoQR": codigoQr,
    "Token": token,
    "Flag": flag,
    "Activo": activo,
    "Nombres": nombres,
    "Apellidos": apellidos,
    "Zona": zona,
    "NumeroEntradas": numeroEntradas,
    "PrecioUnitario": precioUnitario,
  };
}
