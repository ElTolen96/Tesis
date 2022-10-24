class ZonaModel {
  ZonaModel({
    required this.idZona,
    required this.nombre,
    required this.descripcion,
    required this.usuarioCreacion,
    required this.usuarioModiElimini,
    required this.fechaEvento,
    required this.fechaCreacion,
    required this.activo,
  });

  String idZona;
  String nombre;
  String descripcion;
  String usuarioCreacion;
  String usuarioModiElimini;
  DateTime fechaEvento;
  DateTime fechaCreacion;
  String activo;

  factory ZonaModel.fromJson(Map<String, dynamic> json) => ZonaModel(
    idZona: json["IdZona"],
    nombre: json["Nombre"],
    descripcion: json["Descripcion"],
    usuarioCreacion: json["UsuarioCreacion"],
    usuarioModiElimini: json["UsuarioModiElimini"],
    fechaEvento: DateTime.parse(json["FechaEvento"]),
    fechaCreacion: DateTime.parse(json["FechaCreacion"]),
    activo: json["Activo"],
  );

  Map<String, dynamic> toJson() => {
    "IdZona": idZona,
    "Nombre": nombre,
    "Descripcion": descripcion,
    "UsuarioCreacion": usuarioCreacion,
    "UsuarioModiElimini": usuarioModiElimini,
    "FechaEvento": fechaEvento.toIso8601String(),
    "FechaCreacion": fechaCreacion.toIso8601String(),
    "Activo": activo,
  };
}
