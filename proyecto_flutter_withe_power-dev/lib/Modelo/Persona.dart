class PersonaModel {
  PersonaModel({
    required this.idUsuario,
    required this.idPersona,
    required this.email,
    required this.userName,
    required this.fechaCreacion,
    required this.clave,
    required this.imagen,
    required this.idRol,
    required this.idEmpresa,
    required this.idTipoRegistro,
    required this.activo,
    required this.docTipo,
    required this.docNumero,
    required this.nombres,
    required this.apellidos,
    required this.genero,
    required this.telefono,
    required this.fechaNacimiento,
    required this.idCiudad,
    required this.direccion,
    required this.codigoPostal,
    required this.nameRole,
    required this.empresa,
  });

  String idUsuario;
  String idPersona;
  String email;
  String userName;
  DateTime fechaCreacion;
  String clave;
  String imagen;
  String idRol;
  String idEmpresa;
  String idTipoRegistro;
  String activo;
  String docTipo;
  String docNumero;
  String nombres;
  String apellidos;
  String genero;
  String telefono;
  DateTime fechaNacimiento;
  String idCiudad;
  String direccion;
  String codigoPostal;
  String nameRole;
  String empresa;

  factory PersonaModel.fromJson(Map<String, dynamic> json) => PersonaModel(
    idUsuario: json["IdUsuario"],
    idPersona: json["IdPersona"],
    email: json["Email"],
    userName: json["UserName"],
    fechaCreacion: DateTime.parse(json["FechaCreacion"]),
    clave: json["Clave"],
    imagen: json["Imagen"],
    idRol: json["IdRol"],
    idEmpresa: json["IdEmpresa"],
    idTipoRegistro: json["IdTipoRegistro"],
    activo: json["Activo"],
    docTipo: json["DocTipo"],
    docNumero: json["DocNumero"],
    nombres: json["Nombres"],
    apellidos: json["Apellidos"],
    genero: json["Genero"],
    telefono: json["Telefono"],
    fechaNacimiento: DateTime.parse(json["FechaNacimiento"]),
    idCiudad: json["IdCiudad"],
    direccion: json["Direccion"],
    codigoPostal: json["CodigoPostal"],
    nameRole: json["NameRole"],
    empresa: json["Empresa"],
  );

  Map<String, dynamic> toJson() => {
    "IdUsuario": idUsuario,
    "IdPersona": idPersona,
    "Email": email,
    "UserName": userName,
    "FechaCreacion": fechaCreacion.toIso8601String(),
    "Clave": clave,
    "Imagen": imagen,
    "IdRol": idRol,
    "IdEmpresa": idEmpresa,
    "IdTipoRegistro": idTipoRegistro,
    "Activo": activo,
    "DocTipo": docTipo,
    "DocNumero": docNumero,
    "Nombres": nombres,
    "Apellidos": apellidos,
    "Genero": genero,
    "Telefono": telefono,
    "FechaNacimiento": "${fechaNacimiento.year.toString().padLeft(4, '0')}-${fechaNacimiento.month.toString().padLeft(2, '0')}-${fechaNacimiento.day.toString().padLeft(2, '0')}",
    "IdCiudad": idCiudad,
    "Direccion": direccion,
    "CodigoPostal": codigoPostal,
    "NameRole": nameRole,
    "Empresa": empresa,
  };
}
