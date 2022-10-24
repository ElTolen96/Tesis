
class EventoModel {
  EventoModel({
    required this.idEvento,
    required this.idSede,
    required this.titulo,
    required this.descripcion,
    required this.aforo,
    required this.fecha,
    required this.hora,
    required this.usuarioCreacion,
    required this.usuarioModiElimini,
    required this.fechaEventoModi,
    required this.fechaCreacion,
    required this.urlImagen,
    required this.flag,
    required this.activo,
    required this.sede,
    required this.ciudadSede,
    required this.direccionSede,
    required this.longitud,
    required this.latitud,
    required this.zonaVip,
    required this.zonaBox,
    required this.zonaGeneral,
    this.favorito,
  });

  String idEvento;
  String idSede;
  String titulo;
  String descripcion;
  String aforo;
  DateTime fecha;
  String hora;
  String usuarioCreacion;
  String usuarioModiElimini;
  DateTime fechaEventoModi;
  DateTime fechaCreacion;
  String urlImagen;
  String flag;
  String activo;
  String sede;
  String ciudadSede;
  String direccionSede;
  String longitud;
  String latitud;
  String zonaVip;
  String zonaBox;
  String zonaGeneral;
  String? favorito;

  factory EventoModel.fromJson(Map<String, dynamic> json) => EventoModel(
    idEvento: json["IdEvento"],
    idSede: json["IdSede"],
    titulo: json["Titulo"],
    descripcion: json["Descripcion"],
    aforo: json["Aforo"],
    fecha: DateTime.parse(json["Fecha"]),
    hora: json["Hora"],
    usuarioCreacion: json["UsuarioCreacion"],
    usuarioModiElimini: json["UsuarioModiElimini"],
    fechaEventoModi: DateTime.parse(json["FechaEventoModi"]),
    fechaCreacion: DateTime.parse(json["FechaCreacion"]),
    urlImagen: json["UrlImagen"],
    flag: json["Flag"],
    activo: json["Activo"],
    sede: json["Sede"],
    ciudadSede: json["CiudadSede"],
    direccionSede: json["DireccionSede"],
    longitud: json["Longitud"],
    latitud: json["Latitud"],
    zonaVip: json["ZonaVip"],
    zonaBox: json["ZonaBox"],
    zonaGeneral: json["ZonaGeneral"],
    favorito: json["Favorito"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "IdEvento": idEvento,
    "IdSede": idSede,
    "Titulo": titulo,
    "Descripcion": descripcion,
    "Aforo": aforo,
    "Fecha": "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
    "Hora": hora,
    "UsuarioCreacion": usuarioCreacion,
    "UsuarioModiElimini": usuarioModiElimini,
    "FechaEventoModi": fechaEventoModi.toIso8601String(),
    "FechaCreacion": fechaCreacion.toIso8601String(),
    "UrlImagen": urlImagen,
    "Flag": flag,
    "Activo": activo,
    "Sede": sede,
    "CiudadSede": ciudadSede,
    "DireccionSede": direccionSede,
    "Longitud": longitud,
    "Latitud": latitud,
    "ZonaVip": zonaVip,
    "ZonaBox": zonaBox,
    "ZonaGeneral": zonaGeneral,
    "Favorito": favorito,
  };
}
