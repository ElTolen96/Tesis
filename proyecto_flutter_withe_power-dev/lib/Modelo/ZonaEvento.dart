class ZonaEventoModel {
  ZonaEventoModel({
    required this.nombre,
    required this.descripcion,
    required this.aforo,
    required this.precio,
  });

  String nombre;
  String descripcion;
  int aforo;
  int precio;

  factory ZonaEventoModel.fromJson(Map<String, dynamic> json) => ZonaEventoModel(
    nombre: json["Nombre"],
    descripcion: json["Descripcion"],
    aforo: json["Aforo"],
    precio: json["Precio"],
  );

  Map<String, dynamic> toJson() => {
    "Nombre": nombre,
    "Descripcion": descripcion,
    "Aforo": aforo,
    "Precio": precio,
  };
}
