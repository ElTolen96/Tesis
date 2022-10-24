import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_withe_power/Controlador/navegacion.dart';
import 'package:proyecto_withe_power/Modelo/Mensajes.dart';
import 'package:proyecto_withe_power/Vista/daniel/input_field_password_widget.dart';
import 'package:proyecto_withe_power/Vista/daniel/textfield_normal_Icons_widget.dart';

class OlvidarContrasenaPage3 extends StatefulWidget {
  static final String routeName = Mensajes.RUTA_OLVIDARCONTRASENA3USUARIO;

  const OlvidarContrasenaPage3({Key? key});

  @override
  _OlvidarContrasenaPage3State createState() => _OlvidarContrasenaPage3State();
}

class _OlvidarContrasenaPage3State extends State<OlvidarContrasenaPage3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: GestureDetector(
                onTap: () {
                  Navegacion.ir_LOGINUSUARIO(context);
                },
                child: Container(
                  height: 48,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0XFF4760FF),
                      borderRadius: BorderRadius.circular(14)),
                  child: Center(
                      child: Text(
                    "Guardar Clave",
                    style:
                        GoogleFonts.openSans(fontSize: 16, color: Colors.white),
                  )),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Text(
                    "Restablece tu contraseña",
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Con esta nueva clave podrás ingresar a tu cuenta.",
                    style: GoogleFonts.openSans(color: Colors.black38),
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  InputFieldPasswordWidget(texto: "Contraseña",),
                  InputFieldPasswordWidget(texto: "Confirmar contraseña",),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
