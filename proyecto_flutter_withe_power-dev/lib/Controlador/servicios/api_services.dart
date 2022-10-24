import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:proyecto_withe_power/Controlador/servicios/constants.dart';
import 'package:proyecto_withe_power/Modelo/Entrada.dart';
import 'package:proyecto_withe_power/Modelo/Perfil.dart';
import 'package:proyecto_withe_power/Modelo/Respuesta.dart';
import 'package:proyecto_withe_power/Modelo/Usuario.dart';
import 'package:proyecto_withe_power/Modelo/VentaMP.dart';
import 'package:proyecto_withe_power/Modelo/Zona.dart';

import '../../Modelo/Envio_venta.dart';
import '../../Modelo/Evento.dart';
import '../../Modelo/Notificacion.dart';
import '../../Modelo/Persona.dart';
import '../../Modelo/Venta.dart';

class APIServices {
  Logger logger = Logger();

  Future<RespuestaModel?> postRegistrarUsuario(UsuarioModel usuarioModel) async {
    try {
      String path = "$pathProduction/?OpcionObjeto=1&Opcion=1";
      Uri _uri = Uri.parse(path);
      int resultado;
      http.Response response = await http.post(
        _uri,
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
        },
        // body: json.encode({
        //   "dni": "47707720",
        //   "password": "3volution",
        //   "nombreCompleto": "Felipe Montes",
        //   "telefono": "969461011",
        //   "direccion": "Av. Tapia 232"
        // }),
        body: json.encode(
          usuarioModel.toJson(),
        ),
      );
      Map<String, dynamic> myMap = json.decode(response.body);
      RespuestaModel respuestaModel = RespuestaModel.fromJson(myMap);
      return respuestaModel;
    } on TimeoutException catch (e) {
      logger.i(e);
      return Future.error("Error internet 1");
    } on SocketException catch (e) {
      logger.d(e);
      return Future.error("Error internet 2");
    } on Error catch (e) {
      logger.e(e);
      return Future.error("Error internet 3");
    }
  }

  Future<RespuestaModel?> postEditarUsuario(UsuarioModel usuarioModel) async {
    try {
      String path = "$pathProduction/?OpcionObjeto=1&Opcion=2";
      Uri _uri = Uri.parse(path);
      int resultado;
      http.Response response = await http.post(
        _uri,
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
        },
        // body: json.encode({
        //   "dni": "47707720",
        //   "password": "3volution",
        //   "nombreCompleto": "Felipe Montes",
        //   "telefono": "969461011",
        //   "direccion": "Av. Tapia 232"
        // }),
        body: json.encode(
          usuarioModel.toJson(),
        ),
      );

      Map<String, dynamic> myMap = json.decode(response.body);
      RespuestaModel respuestaModel = RespuestaModel.fromJson(myMap);
      return respuestaModel;

    } on TimeoutException catch (e) {
      logger.i(e);
      return Future.error("Error internet 1");
    } on SocketException catch (e) {
      logger.d(e);
      return Future.error("Error internet 2");
    } on Error catch (e) {
      logger.e(e);
      return Future.error("Error internet 3");
    }
  }

  Future<List<PerfilModel>> getIniciarsesion(String usuario, String clave) async {
    List<PerfilModel> perfil = [];

    String path =
        "$pathProduction/?OpcionObjeto=1&Opcion=2&Usuario=$usuario&Clave=$clave&ind=2";
    Uri _uri = Uri.parse(path);
    http.Response response = await http.get(_uri);

    try {
      if (response.statusCode == 200) {
        String source = Utf8Decoder().convert(response.bodyBytes);
        final jsonBody = json.decode(source) as List;
        perfil = jsonBody.map((data) => PerfilModel.fromJson(data)).toList();
        return perfil;
      }
    } on TimeoutException catch (e) {
      return Future.error(e);
    } on SocketException catch (e) {
      //Esto es cuando no hay internet
      return Future.error(e);
    } on Error catch (e) {
      return Future.error(e);
    } on Exception catch (e) {
      // only executed if error is of type Exception
      return Future.error(e);
    }
    return perfil;
  }

  Future<List<PersonaModel>> getListarUsuarioEspecifico(String IdUsuario) async {
    List<PersonaModel> perfil = [];

    String path =
        "$pathProduction/?OpcionObjeto=1&Opcion=3&IdUsuario=$IdUsuario";
    Uri _uri = Uri.parse(path);
    http.Response response = await http.get(_uri);

    try {
      if (response.statusCode == 200) {
        String source = Utf8Decoder().convert(response.bodyBytes);
        final jsonBody = json.decode(source) as List;
        perfil = jsonBody.map((data) => PersonaModel.fromJson(data)).toList();
        return perfil;
      }
    } on TimeoutException catch (e) {
      return Future.error(e);
    } on SocketException catch (e) {
      //Esto es cuando no hay internet
      return Future.error(e);
    } on Error catch (e) {
      return Future.error(e);
    } on Exception catch (e) {
      // only executed if error is of type Exception
      return Future.error(e);
    }
    return perfil;
  }

  Future<List<EventoModel>> getEventos() async {
    String path = "$pathProduction/?OpcionObjeto=2&Opcion=1";
    Uri _uri = Uri.parse(path);
    http.Response response = await http.get(_uri);
    List<EventoModel> eventos = [];
    try {
      if (response.statusCode == 200) {
        String source = Utf8Decoder().convert(response.bodyBytes);
        final jsonBody = json.decode(source) as List;
        eventos = jsonBody.map((data) => EventoModel.fromJson(data)).toList();
        return eventos;
      }
    } on TimeoutException catch (e) {
      return Future.error(e);
    } on SocketException catch (e) {
      //Esto es cuando no hay internet
      return Future.error(e);
    } on Error catch (e) {
      return Future.error(e);
    } on Exception catch (e) {
      // only executed if error is of type Exception
      return Future.error(e);
    }
    return eventos;
  }

  Future<List<NotificacionModel>> getNotificaciones(String idUsuario) async {
    String path = "$pathProduction/?OpcionObjeto=8&Opcion=1&IdUsuario=$idUsuario";
    Uri uri = Uri.parse(path);
    http.Response response = await http.get(uri);
    List<NotificacionModel> notificaciones = [];
    try {
      if (response.statusCode == 200) {
        String source = Utf8Decoder().convert(response.bodyBytes);
        final jsonBody = json.decode(source) as List;
        notificaciones = jsonBody.map((data) => NotificacionModel.fromJson(data)).toList();
        return notificaciones;
      }
    } on TimeoutException catch (e) {
      return Future.error(e);
    } on SocketException catch (e) {
      //Esto es cuando no hay internet
      return Future.error(e);
    } on Error catch (e) {
      return Future.error(e);
    } on Exception catch (e) {
      // only executed if error is of type Exception
      return Future.error(e);
    }
    return notificaciones;
  }

  Future<List<ZonaModel>> getZona(String idZona) async {
    List<ZonaModel> zona = [];
    try {
      String path = "$pathProduction/?OpcionObjeto=7&Opcion=2&IdZona=$idZona";
      Uri _uri = Uri.parse(path);
      http.Response response = await http.get(
        _uri,
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
        },
      );

      if (response.statusCode == 200) {
        String source = Utf8Decoder().convert(response.bodyBytes);
        final jsonBody = json.decode(source) as List;
        zona = jsonBody.map((data) => ZonaModel.fromJson(data)).toList();
        return zona;
      }
    } on TimeoutException catch (e) {
      logger.i(e);
      return Future.error("Error internet 1");
    } on SocketException catch (e) {
      logger.d(e);
      return Future.error("Error internet 2");
    } on Error catch (e) {
      logger.e(e);
      return Future.error("Error internet 3");
    }
    return zona;
  }

  Future<VentaModel?> postVenta(EnvioVentaModel envioVentaModel) async {
    try {
      String path = "https://api.culqi.com/v2/charges";
      Uri _uri = Uri.parse(path);
      int resultado;
      http.Response response = await http.post(
        _uri,
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
        },
        // body: json.encode({
        //   "dni": "47707720",
        //   "password": "3volution",
        //   "nombreCompleto": "Felipe Montes",
        //   "telefono": "969461011",
        //   "direccion": "Av. Tapia 232"
        // }),
        body: json.encode(
          envioVentaModel.toJson(),
        ),
      );

      Map<String, dynamic> myMap = json.decode(response.body);
      print(myMap);
      VentaModel respuestaModel = VentaModel.fromJson(myMap);
      return respuestaModel;

    } on TimeoutException catch (e) {
      logger.i(e);
      return Future.error("Error internet 1 ${e.message}");
    } on SocketException catch (e) {
      logger.d(e);
      return Future.error("Error internet 2 ${e.message}");
    } on Error catch (e) {
      logger.e(e);
      return Future.error("Error internet 3 ");
    }
  }

  Future<VentaModel?> postToken(EnvioVentaModel envioVentaModel) async {
    try {
      String path = "https://secure.culqi.com/v2/tokens";
      Uri _uri = Uri.parse(path);
      int resultado;
      http.Response response = await http.post(
        _uri,
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
        },
        // body: json.encode({
        //   "dni": "47707720",
        //   "password": "3volution",
        //   "nombreCompleto": "Felipe Montes",
        //   "telefono": "969461011",
        //   "direccion": "Av. Tapia 232"
        // }),
        body: json.encode(
          envioVentaModel.toJson(),
        ),
      );

      Map<String, dynamic> myMap = json.decode(response.body);
      print(myMap);
      VentaModel respuestaModel = VentaModel.fromJson(myMap);
      return respuestaModel;

    } on TimeoutException catch (e) {
      logger.i(e);
      return Future.error("Error internet 1 ${e.message}");
    } on SocketException catch (e) {
      logger.d(e);
      return Future.error("Error internet 2 ${e.message}");
    } on Error catch (e) {
      logger.e(e);
      return Future.error("Error internet 3 ");
    }
  }

  Future<int?> postRegistrarVenta(VentaMpModel ventaMpModel) async {
    try {
      String path = "$pathProduction/?OpcionObjeto=4&Opcion=1";
      Uri _uri = Uri.parse(path);
      int resultado;
      http.Response response = await http.post(
        _uri,
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
        },
        // body: json.encode({
        //   "dni": "47707720",
        //   "password": "3volution",
        //   "nombreCompleto": "Felipe Montes",
        //   "telefono": "969461011",
        //   "direccion": "Av. Tapia 232"
        // }),
        body: json.encode(
          ventaMpModel.toJson(),
        ),
      );

    } on TimeoutException catch (e) {
      logger.i(e);
      return Future.error("Error internet 1");
    } on SocketException catch (e) {
      logger.d(e);
      return Future.error("Error internet 2");
    } on Error catch (e) {
      logger.e(e);
      return Future.error("Error internet 3");
    }
  }

  Future<List<EntradaModel>> getEntradas(String idUsuario) async {
    String path = "$pathProduction/?OpcionObjeto=6&Opcion=1&IdUsuario=$idUsuario";
    Uri uri = Uri.parse(path);
    http.Response response = await http.get(uri);
    List<EntradaModel> entradas = [];
    try {
      if (response.statusCode == 200) {
        String source = Utf8Decoder().convert(response.bodyBytes);
        final jsonBody = json.decode(source) as List;
        entradas = jsonBody.map((data) => EntradaModel.fromJson(data)).toList();
        return entradas;
      }
    } on TimeoutException catch (e) {
      return Future.error(e);
    } on SocketException catch (e) {
      //Esto es cuando no hay internet
      return Future.error(e);
    } on Error catch (e) {
      return Future.error(e);
    } on Exception catch (e) {
      // only executed if error is of type Exception
      return Future.error(e);
    }
    return entradas;
  }
}
