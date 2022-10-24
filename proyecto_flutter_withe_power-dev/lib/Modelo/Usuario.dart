class UsuarioModel {
  String? IdUsuario;
  String? docTipo;
  String? docNumero;
  String? apellidos;
  String? nombres;
  String? genero;
  String? telefono;
  String? fechaNacimiento;
  String? ciudad;
  String? direccion;
  String? codigoPostal;
  String? email;
  String? userName;
  String? clave;
  String? imagen;
  int? idRol;
  int? idEmpresa;
  int? idTipoRegistro;

  UsuarioModel(
      {this.docTipo,
        this.IdUsuario,
        this.docNumero,
        this.apellidos,
        this.nombres,
        this.genero,
        this.telefono,
        this.fechaNacimiento,
        this.ciudad,
        this.direccion,
        this.codigoPostal,
        this.email,
        this.userName,
        this.clave,
        this.imagen,
        this.idRol,
        this.idEmpresa,
        this.idTipoRegistro});

  UsuarioModel.fromJson(Map<String, dynamic> json) {
    IdUsuario = json['IdUsuario'];
    docTipo = json['DocTipo'];
    docNumero = json['DocNumero'];
    apellidos = json['Apellidos'];
    nombres = json['Nombres'];
    genero = json['Genero'];
    telefono = json['Telefono'];
    fechaNacimiento = json['FechaNacimiento'];
    ciudad = json['Ciudad'];
    direccion = json['Direccion'];
    codigoPostal = json['CodigoPostal'];
    email = json['Email'];
    userName = json['UserName'];
    clave = json['Clave'];
    imagen = json['Imagen'];
    idRol = json['IdRol'];
    idEmpresa = json['IdEmpresa'];
    idTipoRegistro = json['IdTipoRegistro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IdUsuario'] = this.IdUsuario;
    data['DocTipo'] = this.docTipo;
    data['DocNumero'] = this.docNumero;
    data['Apellidos'] = this.apellidos;
    data['Nombres'] = this.nombres;
    data['Genero'] = this.genero;
    data['Telefono'] = this.telefono;
    data['FechaNacimiento'] = this.fechaNacimiento;
    data['Ciudad'] = this.ciudad;
    data['Direccion'] = this.direccion;
    data['CodigoPostal'] = this.codigoPostal;
    data['Email'] = this.email;
    data['UserName'] = this.userName;
    data['Clave'] = this.clave;
    data['Imagen'] = this.imagen;
    data['IdRol'] = this.idRol;
    data['IdEmpresa'] = this.idEmpresa;
    data['IdTipoRegistro'] = this.idTipoRegistro;
    return data;
  }
}



