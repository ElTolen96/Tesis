import 'package:flutter/material.dart';
import 'package:proyecto_withe_power/Modelo/Mensajes.dart';
import 'package:proyecto_withe_power/Vista/Crud/ZonaBox.dart';
import 'package:proyecto_withe_power/Vista/Crud/ZonaGeneral.dart';
import 'package:proyecto_withe_power/Vista/Crud/ZonaVip.dart';

import '../Vista/Crud/DetalleCompra.dart';

class Navegacion {
  
  static void goToWelcome(BuildContext context) {
    Navigator.pushNamed(context, "/welcome");
  }

  static void ir_LOGIN(BuildContext context) {
    Navigator.pushNamed(context, Mensajes.RUTA_LOGIN);
  }

  static void ir_REGISTROUSUARIO(BuildContext context) {
    Navigator.pushNamed(context, Mensajes.RUTA_REGISTROUSUARIO);
  }

  static void ir_REGISTRO_CELULAR_USUARIO(BuildContext context) {
    Navigator.pushNamed(context, Mensajes.RUTA_REGISTRO_CELULAR_USUARIO);
  }

  static void ir_LOGINUSUARIO(BuildContext context) {
    Navigator.pushNamed(context, Mensajes.RUTA_LOGINUSUARIO );
  }

  static void ir_OLVIDARCONTRASENA1USUARIO(BuildContext context) {
    Navigator.pushNamed(context, Mensajes.RUTA_OLVIDARCONTRASENA1USUARIO );
  }

  static void ir_OLVIDARCONTRASENA2USUARIO(BuildContext context) {
    Navigator.pushNamed(context, Mensajes.RUTA_OLVIDARCONTRASENA2USUARIO );
  }

  static void ir_OLVIDARCONTRASENA3USUARIO(BuildContext context) {
    Navigator.pushNamed(context, Mensajes.RUTA_OLVIDARCONTRASENA3USUARIO );
  }

  static void ir_HOMEIMAGEN1USUARIO(BuildContext context) {
    Navigator.pushNamed(context, Mensajes.RUTA_HOMEIMAGEN1USUARIO );
  }

  static void ir_HOMEIMAGEN2USUARIO(BuildContext context) {
    Navigator.pushNamed(context, Mensajes.RUTA_HOMEIMAGEN2USUARIO );
  }

  static void ir_HOMEIMAGEN3USUARIO(BuildContext context) {
    Navigator.pushNamed(context, Mensajes.RUTA_HOMEIMAGEN3USUARIO );
  }

  static void ir_Inicio(BuildContext context) {
    Navigator.pushNamed(context, Mensajes.RUTA_HOMEUSUARIO);
  }

  static void ir_EditarUsuario(BuildContext context) {
    Navigator.pushNamed(context, Mensajes.RUTA_EDITUSUARIO);
  }

  static void ir_NotificarUsuario(BuildContext context) {
    Navigator.pushNamed(context, Mensajes.RUTA_NOTIFICARUSUARIO);
  }

  static void ir_EntradasUsuario(BuildContext context) {
    Navigator.pushNamed(context, Mensajes.RUTA_ENTRADARUSUARIO);
  }

  static void ir_FavoritoUsuario(BuildContext context) {
    Navigator.pushNamed(context, Mensajes.RUTA_FAVORITOUSUARIO);
  }

  static void ir_ZonaVip(BuildContext context) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) => ZonaVip()), (router) => false);
  }
  static void ir_ZonaBox(BuildContext context) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) => ZonaBox()), (router) => false);
  }

  static void ir_ZonaGeneral(BuildContext context) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) => ZonaGeneral()), (router) => false);
  }

  static void ir_DetalleCompra(BuildContext context) {

    Navigator.pushNamed(context, Mensajes.RUTA_DETALLECOMPRA);
  }

  static goToInicio(BuildContext context) {
     Navigator.pushNamed(context, "/inicio");
  }

}
