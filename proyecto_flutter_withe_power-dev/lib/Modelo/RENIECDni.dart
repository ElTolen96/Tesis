
class ReniecDNIModel{
  String? dni;
  String? nombres;
  String? apellidoPaterno;
  String? apellidoMaterno;

  ReniecDNIModel({
    this.dni,
    this.nombres,
    this.apellidoPaterno,
    this.apellidoMaterno,
  });

  factory ReniecDNIModel.fromJson(Map<String, dynamic> json) => ReniecDNIModel(
    dni: json["dni"],
    nombres: json["nombres"],
    apellidoPaterno: json["apellidoPaterno"],
    apellidoMaterno: json["apellidoMaterno"],
  );

  Map<String, dynamic> toJson() => {
    "dni": dni,
    "nombres": nombres,
    "apellidoPaterno": apellidoPaterno,
    "apellidoMaterno": apellidoMaterno,
  };

}