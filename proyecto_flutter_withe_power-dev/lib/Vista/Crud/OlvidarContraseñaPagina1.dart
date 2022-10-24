import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_withe_power/Controlador/navegacion.dart';
import 'package:proyecto_withe_power/Modelo/Mensajes.dart';
import 'package:proyecto_withe_power/Vista/daniel/textfield_normal_Icons_widget.dart';

class OlvidarContrasenaPage1 extends StatefulWidget {
  static final String routeName = Mensajes.RUTA_OLVIDARCONTRASENA1USUARIO;

  const OlvidarContrasenaPage1({Key? key});

  @override
  _OlvidarContrasenaPage1State createState() => _OlvidarContrasenaPage1State();
}

class _OlvidarContrasenaPage1State extends State<OlvidarContrasenaPage1> {
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
                onTap: (){
                  Navegacion.ir_OLVIDARCONTRASENA2USUARIO(context);
                },
                child: Container(
                  height: 48,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0XFF4760FF),
                      borderRadius: BorderRadius.circular(14)),
                  child: Center(child: Text("Enviar", style: GoogleFonts.openSans(fontSize: 16, color: Colors.white),)),
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
                    "Olvide mi contraseña",
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Ingresa tu correo y te enviaremos la información para cambiar tu clave.",
                    style: GoogleFonts.openSans(color: Colors.black38),
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  TextFieldNormalIconWidget(
                    hintText: 'Correo Electronico',
                    active: false,
                    icons: Icons.email,
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
