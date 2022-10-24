import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_withe_power/Controlador/navegacion.dart';
import 'package:proyecto_withe_power/Modelo/Mensajes.dart';
import 'package:proyecto_withe_power/Vista/daniel/textfield_normal_Icons_widget.dart';
import 'package:proyecto_withe_power/Vista/daniel/validar_codigo.dart';

class OlvidarContrasenaPage2 extends StatefulWidget {
  static final String routeName = Mensajes.RUTA_OLVIDARCONTRASENA2USUARIO;

  const OlvidarContrasenaPage2({Key? key});

  @override
  _OlvidarContrasenaPage2State createState() => _OlvidarContrasenaPage2State();
}

class _OlvidarContrasenaPage2State extends State<OlvidarContrasenaPage2> {
  TextEditingController _codigo1Controller = TextEditingController();
  TextEditingController _codigo2Controller = TextEditingController();
  TextEditingController _codigo3Controller = TextEditingController();
  TextEditingController _codigo4Controller = TextEditingController();
  TextEditingController _codigo5Controller = TextEditingController();
  TextEditingController _codigo6Controller = TextEditingController();

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
                  Navegacion.ir_OLVIDARCONTRASENA3USUARIO(context);
                },
                child: Container(
                  height: 48,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0XFF4760FF),
                      borderRadius: BorderRadius.circular(14)),
                  child: Center(
                      child: Text(
                    "Validar Código",
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
                    "Ingresa el código que te hemos enviado a tu correo",
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      validar_codigo(codigo: "1", controller: _codigo1Controller),
                      validar_codigo(codigo: "2", controller: _codigo2Controller),
                      validar_codigo(codigo: "3", controller: _codigo3Controller),
                      validar_codigo(codigo: "4", controller: _codigo4Controller),
                      validar_codigo(codigo: "5", controller: _codigo5Controller),
                      validar_codigo(codigo: "6", controller: _codigo6Controller),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Te hemos enviado un código de seguridad al correo para que cambies tu clave.",
                    style: GoogleFonts.openSans(
                        fontSize: 16, color: Colors.black38),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Enviar un nuevo código",
                    style:
                        GoogleFonts.openSans(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
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
