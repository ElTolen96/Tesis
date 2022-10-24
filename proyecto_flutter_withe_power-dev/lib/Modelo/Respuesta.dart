class RespuestaModel {
  RespuestaModel({
    required this.resultado,
    required this.mensaje,
  });

  String resultado;
  String mensaje;

  factory RespuestaModel.fromJson(Map<String, dynamic> json) => RespuestaModel(
    resultado: json["resultado"],
    mensaje: json["mensaje"],
  );

  Map<String, dynamic> toJson() => {
    "resultado": resultado,
    "mensaje": mensaje,
  };
}
