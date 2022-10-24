import 'package:proyecto_withe_power/Modelo/Mensajes.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia = PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  late SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  set logueado(bool value){
    _prefs.setBool("logueado", value);
  }

  bool get logueado {
    return _prefs.getBool("logueado") ?? false;
  }

  // GET y SET del Genero
  String get genero {
    return _prefs.getString('usuarioGenero') ?? '';
  }

  set genero(String value) {
    _prefs.setString('usuarioGenero', value);
  }

  // GET y SET del _colorSecundario
  bool get colorSecundario {
    return _prefs.getBool('colorSecundario') ?? false;
  }

  set colorSecundario(bool value) {
    _prefs.setBool('colorSecundario', value);
  }

  // GET y SET del nombreUsuario
  String get usuarioNombre {
    return _prefs.getString('usuarioNombre') ?? '';
  }

  set usuarioNombre(String value) {
    _prefs.setString('usuarioNombre', value);
  }

  String get usuarioDni {
    return _prefs.getString('usuarioDni') ?? '';
  }

  set usuarioDni(String value) {
    _prefs.setString('usuarioDni', value);
  }

  String get usuarioTelefono {
    return _prefs.getString('usuarioTelefono') ?? '';
  }

  set usuarioTelefono(String value) {
    _prefs.setString('usuarioTelefono', value);
  }

  String get usuarioApellidos {
    return _prefs.getString('usuarioApellidos') ?? '';
  }

  set usuarioApellidos(String value) {
    _prefs.setString('usuarioApellidos', value);
  }

  String get usuarioFechaNacimiento {
    return _prefs.getString('usuarioFechaNacimiento') ?? '';
  }

  set usuarioFechaNacimiento(String value) {
    _prefs.setString('usuarioFechaNacimiento', value);
  }

  set usuarioEmail(String value) {
    _prefs.setString('usuarioEmail', value);
  }

  String get usuarioEmail {
    return _prefs.getString('usuarioEmail') ?? '';
  }

  String get usuarioDireccion {
    return _prefs.getString('usuarioDireccion') ?? '';
  }

  set usuarioDireccion(String value) {
    _prefs.setString('usuarioDireccion', value);
  }

  String get usuarioGenero {
    return _prefs.getString('usuarioGenero') ?? '';
  }

  set usuarioGenero(String value) {
    _prefs.setString('usuarioGenero', value);
  }

  String get Usuario {
    return _prefs.getString('Usuario') ?? '';
  }

  set Usuario(String value) {
    _prefs.setString('Usuario', value);
  }

  set usuarioCodigo(String value) {
    _prefs.setString('usuarioCodigo', value);
  }

  String get IdUsuario {
    return _prefs.getString('IdUsuario') ?? '';
  }

  set IdUsuario(String value) {
    _prefs.setString('IdUsuario', value);
  }

  String get usuarioCodigo {
    return _prefs.getString('usuarioCodigo') ?? '';
  }

  String get usuarioFundo {
    return _prefs.getString('usuarioFundo') ?? '';
  }

  set usuarioFundo(String value) {
    _prefs.setString('usuarioFundo', value);
  }

  // GET y SET de la última página
  String get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'login';
  }

  set ultimaPagina(String value) {
    _prefs.setString('ultimaPagina', value);
  }

  String get getvalidarSesion {
    late String res;
    if (_prefs.getString('Usuario') == null ||
        _prefs.getString('Usuario') == '') {
      res = Mensajes.RUTA_LOGIN;
    } else {
      res = ultimaPagina;
    }
    return res;
  }

  void getCerrarSesion() {
    ultimaPagina = Mensajes.RUTA_LOGIN;
    Usuario = '';
    usuarioNombre = '';
  }
}
