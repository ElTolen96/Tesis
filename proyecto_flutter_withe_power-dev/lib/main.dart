import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:proyecto_withe_power/Controlador/preferencias_usuario.dart';
import 'package:proyecto_withe_power/Modelo/Mensajes.dart';
import 'package:proyecto_withe_power/Vista/Crud/DetalleCompra.dart';
import 'package:proyecto_withe_power/Vista/Crud/EditarUsuario.dart';
import 'package:proyecto_withe_power/Vista/Crud/EntradaUsuario.dart';
import 'package:proyecto_withe_power/Vista/Crud/FavoritoUsuario.dart';
import 'package:proyecto_withe_power/Vista/Crud/HomeImage1.dart';
import 'package:proyecto_withe_power/Vista/Crud/HomeImage2.dart';
import 'package:proyecto_withe_power/Vista/Crud/HomeImage3.dart';
import 'package:proyecto_withe_power/Vista/Crud/HomePage.dart';
import 'package:proyecto_withe_power/Vista/Crud/LoginUsuario.dart';
import 'package:proyecto_withe_power/Vista/Crud/Notification.dart';
import 'package:proyecto_withe_power/Vista/Crud/OlvidarContrase%C3%B1aPagina1.dart';
import 'package:proyecto_withe_power/Vista/Crud/OlvidarContrase%C3%B1aPagina2.dart';
import 'package:proyecto_withe_power/Vista/Crud/OlvidarContrase%C3%B1aPagina3.dart';
import 'package:proyecto_withe_power/Vista/Crud/RegistroCelular.dart';
import 'package:proyecto_withe_power/Vista/Crud/RegistroUsuario.dart';
import 'package:proyecto_withe_power/Vista/Crud/TabsPage.dart';
import 'package:proyecto_withe_power/Vista/Crud/ZonaVip.dart';
import 'package:proyecto_withe_power/Vista/Eventos%20Disenio/provider.dart';
import 'package:proyecto_withe_power/Vista/Eventos%20Disenio/splash_screen.dart';
import 'package:proyecto_withe_power/Vista/Iniciales/Login.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = PreferenciasUsuario();
  await Firebase.initializeApp();
  await prefs.initPrefs();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final prefs = PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('es', 'ES'), // Spanish, no country code
        ],
        title: Mensajes.LOGIN_BIENVENIDA,
        initialRoute: prefs.getvalidarSesion,
        theme: ThemeData(
            fontFamily: 'Poppins',
            primaryColor: Colors.red,
            colorScheme: ColorScheme.fromSwatch()
                .copyWith(secondary: Colors.yellowAccent)),
        debugShowCheckedModeBanner: false,
        home: PreInit(),
        routes: routes,
      ),
    );
  }
}

class PreInit extends StatelessWidget {

  PreferenciasUsuario prefs = PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return prefs.logueado ?  TabsPage(selectedIndex: 0) : SplashScreenPage();
  }
}

var routes = <String, WidgetBuilder>{
  Mensajes.RUTA_LOGIN: (BuildContext context) => Login(),
 // Mensajes.RUTA_REGISTROUSUARIO: (BuildContext context) =>  RegistroUsuario(),
  Mensajes.RUTA_REGISTRO_CELULAR_USUARIO: (BuildContext context) => const RegistroCelular(),
  Mensajes.RUTA_LOGINUSUARIO: (BuildContext context) => const LoginUsuario(),
  Mensajes.RUTA_OLVIDARCONTRASENA1USUARIO: (BuildContext context) => const OlvidarContrasenaPage1(),
  Mensajes.RUTA_OLVIDARCONTRASENA2USUARIO: (BuildContext context) => const OlvidarContrasenaPage2(),
  Mensajes.RUTA_OLVIDARCONTRASENA3USUARIO: (BuildContext context) => const OlvidarContrasenaPage3(),
  Mensajes.RUTA_HOMEIMAGEN1USUARIO: (BuildContext context) => const HomeImage1(),
  Mensajes.RUTA_HOMEIMAGEN2USUARIO: (BuildContext context) => const HomeImage2(),
  Mensajes.RUTA_HOMEIMAGEN3USUARIO: (BuildContext context) => const HomeImage3(),
  Mensajes.RUTA_HOMEUSUARIO: (BuildContext context) =>  TabsPage(selectedIndex: 0),
  Mensajes.RUTA_EDITUSUARIO: (BuildContext context) =>  EditarUsuario(),
  Mensajes.RUTA_NOTIFICARUSUARIO: (BuildContext context) =>  NotificarUsuario(),
  Mensajes.RUTA_ENTRADARUSUARIO: (BuildContext context) =>  EntradaUsuario(),
  Mensajes.RUTA_FAVORITOUSUARIO: (BuildContext context) =>  FavoritoUsuario(),
 // Mensajes.RUTA_DETALLECOMPRA: (BuildContext context) =>  DetalleCompra(),

 // "/home": (BuildContext context) => const MenuPrincipalPage(),
};
