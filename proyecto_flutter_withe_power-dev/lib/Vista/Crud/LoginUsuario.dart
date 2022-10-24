import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:proyecto_withe_power/Controlador/navegacion.dart';
import 'package:proyecto_withe_power/Modelo/Mensajes.dart';
import 'package:proyecto_withe_power/Modelo/Perfil.dart';
import 'package:proyecto_withe_power/Vista/daniel/textfield_normal_Icons_widget.dart';

import '../../Controlador/preferencias_usuario.dart';
import '../../Controlador/servicios/api_services.dart';
import '../daniel/general_widget.dart';
import '../daniel/textfield_password_normal_Icons_widget.dart';

class LoginUsuario extends StatefulWidget {
  static final String routeName = Mensajes.RUTA_LOGINUSUARIO;

  const LoginUsuario({Key? key});

  @override
  _LoginUsuarioState createState() => _LoginUsuarioState();
}

class _LoginUsuarioState extends State<LoginUsuario> {
  final APIServices _apiServices = APIServices();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  List<PerfilModel> perfilModel = [ ];
  PreferenciasUsuario _prefs = PreferenciasUsuario();
  final _formCuentaKey = GlobalKey<FormState>();

  getIniciarSesion(String email, String clave) async {
    if(_formCuentaKey.currentState!.validate()){
      _apiServices.getIniciarsesion(email, clave).then((value) {
        perfilModel = value;

        if(perfilModel.first.resultado == "0"){
          _prefs.IdUsuario = perfilModel.first.idUsuario;
          _prefs.Usuario = perfilModel.first.nombres;
          _prefs.usuarioNombre = perfilModel.first.nombres;
          _prefs.usuarioApellidos = perfilModel.first.apellidos;
          _prefs.usuarioEmail = perfilModel.first.email;
          _prefs.usuarioDni = perfilModel.first.docNumero;
          _prefs.usuarioFechaNacimiento = '${perfilModel.first.fechaNacimiento.day}-${perfilModel.first.fechaNacimiento.month}-${perfilModel.first.fechaNacimiento.year}';
          _prefs.usuarioTelefono = perfilModel.first.telefono;
          _prefs.logueado = true;
          messageWelcomeSnackBar(context, "Bienvenido al App Movil");
          Navegacion.ir_HOMEIMAGEN1USUARIO(context);
        }else if (perfilModel.first.resultado == "2"){
          messageSuccessInfoSnackBar(context, "Email Incorrecto");
        }else if(perfilModel.first.resultado == "3"){
          messageSuccessInfoSnackBar(context, "Clave Incorrecta");
        }
        setState(() {

        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formCuentaKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Lottie.asset('assets/images/login.json'),
                      Text(
                        "Indícanos tu correo y contraseña",
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Para poder tener acceso a nuestra aplicación.",
                        style: GoogleFonts.openSans(color: Colors.black38),
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      TextFieldNormalIconWidget(
                        hintText: 'Correo Electronico',
                        active: false,
                        icons: Icons.email,
                        controller: emailController,
                        onTap: (){

                        },
                      ),
                      TextFieldPasswordNormalIconWidget(
                        hintText: 'Contraseña',
                        active: false,
                        icons: Icons.lock,
                        invisible: false,
                        controller: passwordController,
                      ),
                      const SizedBox(height: 20,),
                      GestureDetector(
                        onTap: () {
                          getIniciarSesion(emailController.text, passwordController.text);
                          //Navegacion.ir_HOMEIMAGEN1USUARIO(context);
                        },
                        child: Container(
                          height: 48,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color(0XFF4760FF),
                              borderRadius: BorderRadius.circular(14)),
                          child: Center(
                              child: Text(
                                "Iniciar Sesión",
                                style:
                                GoogleFonts.openSans(fontSize: 16, color: Colors.white),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
