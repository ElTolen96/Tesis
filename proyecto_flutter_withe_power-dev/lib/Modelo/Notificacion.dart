class NotificacionModel {
  NotificacionModel({
    required this.idNotificacion,
    required this.idUsuario,
    required this.idVenta,
    required this.descripcion,
    required this.estado,
    required this.fechaVenta,
    required this.monto,
    required this.zona,
     this.leido,
  });

  String idNotificacion;
  String idUsuario;
  String idVenta;
  String descripcion;
  String estado;
  DateTime fechaVenta;
  String monto;
  String zona;
  String? leido;

  factory NotificacionModel.fromJson(Map<String, dynamic> json) => NotificacionModel(
    idNotificacion: json["IdNotificacion"],
    idUsuario: json["IdUsuario"],
    idVenta: json["IdVenta"],
    descripcion: json["Descripcion"],
    estado: json["Estado"],
    fechaVenta: DateTime.parse(json["FechaVenta"]),
    monto: json["Monto"],
    zona: json["Zona"],
    leido: json["Leido"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "IdNotificacion": idNotificacion,
    "IdUsuario": idUsuario,
    "IdVenta": idVenta,
    "Descripcion": descripcion,
    "Estado": estado,
    "FechaVenta": "${fechaVenta.year.toString().padLeft(4, '0')}-${fechaVenta.month.toString().padLeft(2, '0')}-${fechaVenta.day.toString().padLeft(2, '0')}",
    "Monto": monto,
    "Zona": zona,
    "Leido": leido
  };
}
