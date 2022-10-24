class PerfilModel {
  PerfilModel({
    required this.idUsuario,
    required this.idPersona,
    required this.email,
    required this.userName,
    required this.imagen,
    required this.idTipoRegistro,
    required this.docTipo,
    required this.docNumero,
    required this.nombres,
    required this.apellidos,
    required this.genero,
    required this.telefono,
    required this.fechaNacimiento,
    required this.resultado,
    required this.mensaje,
  });

  String idUsuario;
  String idPersona;
  String email;
  String userName;
  String imagen;
  String idTipoRegistro;
  String docTipo;
  String docNumero;
  String nombres;
  String apellidos;
  String genero;
  String telefono;
  DateTime fechaNacimiento;
  String resultado;
  String mensaje;

  factory PerfilModel.fromJson(Map<String, dynamic> json) => PerfilModel(
    idUsuario: json["IdUsuario"],
    idPersona: json["IdPersona"],
    email: json["Email"],
    userName: json["UserName"],
    imagen: json["Imagen"],
    idTipoRegistro: json["IdTipoRegistro"],
    docTipo: json["DocTipo"],
    docNumero: json["DocNumero"],
    nombres: json["Nombres"],
    apellidos: json["Apellidos"],
    genero: json["Genero"],
    telefono: json["Telefono"],
    fechaNacimiento: DateTime.parse(json["FechaNacimiento"]),
    resultado: json["resultado"],
    mensaje: json["mensaje"],
  );

  Map<String, dynamic> toJson() => {
    "IdUsuario": idUsuario,
    "IdPersona": idPersona,
    "Email": email,
    "UserName": userName,
    "Imagen": imagen,
    "IdTipoRegistro": idTipoRegistro,
    "DocTipo": docTipo,
    "DocNumero": docNumero,
    "Nombres": nombres,
    "Apellidos": apellidos,
    "Genero": genero,
    "Telefono": telefono,
    "FechaNacimiento": "${fechaNacimiento.year.toString().padLeft(4, '0')}-${fechaNacimiento.month.toString().padLeft(2, '0')}-${fechaNacimiento.day.toString().padLeft(2, '0')}",
    "resultado": resultado,
    "mensaje": mensaje,
  };
}
