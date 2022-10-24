import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_withe_power/Controlador/navegacion.dart';
import 'package:proyecto_withe_power/Modelo/Mensajes.dart';
import 'package:proyecto_withe_power/Vista/Eventos%20Disenio/Progreso.dart';
import 'package:proyecto_withe_power/Vista/Eventos%20Disenio/login_animacion.dart';

import '../Crud/RegistroUsuario.dart';

class Login extends StatefulWidget {
  @override
  LoginEstado createState() => LoginEstado();
}

class LoginEstado extends State<Login> {
  GlobalKey<FormState> _formularioLogin = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late final usuario = TextEditingController();
  late final password = TextEditingController();

  bool hidePassword = true;
  bool isApiCallProcess = false;
  //LoginEstado({Key key, this.buttonType}) : super(key: key);
  @override
  void initState() {
    super.initState();
  }

  FocusNode nodeUsuario = FocusNode();
  FocusNode nodeTelefono = FocusNode();
  Widget _mostrarScafool(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: 600,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/Iniciales/login.png'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      /*
                      Positioned(
                        left: 30,
                        width: 80,
                        height: 110,
                        child: LoginAnimacion(
                            1,
                            Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-1.png'))),
                            )),
                      ),
                      Positioned(
                        left: 140,
                        width: 80,
                        height: 150,
                        child: LoginAnimacion(
                            1.3,
                            Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-2.png'))),
                            )),
                      ),
                      Positioned(
                        right: 40,
                        top: 40,
                        width: 80,
                        height: 150,
                        child: LoginAnimacion(
                            1.5,
                            Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/clock.png'))),
                            )),
                      ),*/
                      /*  Positioned(
                        child:
                           LoginAnimacion(
                            1.6,
                            Container(
                              margin: const EdgeInsets.only(top: 50),
                              child: Center(
                                child: Text(
                                  Mensajes.LOGIN_BIENVENIDA,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                      )*/
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          children: <Widget>[
                            /* SizedBox(
                              height: size.height * 0.04,
                            ),*/
                            LoginAnimacion(
                                2,
                                Container(
                                  height: 50,
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        //color: Colors.red,
                                        child: Text(Mensajes.LOGIN_BIENVENIDA,
                                            style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 32,
                                              color: Colors.black,
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium,
                                            )),
                                      )),
                                  /*Text(
                                        "Iniciar Sesión",
                                        textAlign: ,
                                        style: TextStyle(
                                            color: Color.fromARGB(255, 3, 3, 3),
                                            fontWeight: FontWeight.bold),
                                      )
                                */
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            LoginAnimacion(
                                2,
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: const LinearGradient(colors: [
                                        Color.fromARGB(255, 0, 0, 0),
                                        Color.fromARGB(255, 0, 0, 0)
                                      ])),
                                  child: Center(
                                    child: TextButton(
                                      onPressed: () {
                                        Navegacion.ir_LOGINUSUARIO(context);
                                      },
                                      child: Text(Mensajes.LOGIN_INICIARSESION,
                                          style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .displayMedium,
                                          )),
                                    ),
                                  ),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            LoginAnimacion(
                                2,
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: const LinearGradient(colors: [
                                        Color.fromARGB(255, 0, 0, 0),
                                        Color.fromARGB(255, 0, 0, 0),
                                      ])),
                                  child: Center(
                                    child: TextButton(
                                      onPressed: () {

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => RegistroUsuario(
                                                  celular: "12",
                                                )));

                                        //Navegacion.ir_REGISTRO_CELULAR_USUARIO(context);
                                      },
                                      child: Text(Mensajes.LOGIN_CREARCUENTA,
                                          style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .displayMedium,
                                          )),
                                    ),
                                  ),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            Visibility(
                              visible: false,
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ]
                                ),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SvgPicture.asset(
                                            'assets/Generales/icons/bxl-google.svg',
                                          ),
                                          SizedBox(width: 10,),
                                          Text(
                                            "Ingresar con Google",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: false,
                              child: LoginAnimacion(
                                  1.5,
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        child: const Text(
                                            "¿Olvidaste la contraseña?",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color(0xff374151),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.0,
                                            )),
                                        onPressed: () {
                                          Navegacion.ir_OLVIDARCONTRASENA1USUARIO(
                                              context);
                                          //Navegacion.goToRegister(context);
                                        },
                                      ),
                                    ],
                                  )
                                  /*
                                  Text(
                                    "Olvidaste Tu Contraseña?",
                                    style: TextStyle(
                                        color: Color.fromRGBO(143, 148, 251, 1)),
                                  )
                                  */
                                  ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Progreso(
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      child: _mostrarScafool(context),
    );
  }
}
