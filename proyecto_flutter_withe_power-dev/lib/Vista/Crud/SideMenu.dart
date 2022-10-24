import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_withe_power/Controlador/navegacion.dart';
import 'package:proyecto_withe_power/Vista/Crud/EditarUsuario.dart';
import 'package:proyecto_withe_power/Vista/Crud/TabsPage.dart';
import 'package:proyecto_withe_power/Vista/Eventos%20Disenio/splash_screen.dart';
import 'package:proyecto_withe_power/Vista/daniel/item_option_slider_menu.dart';

import '../../Controlador/preferencias_usuario.dart';
import '../daniel/dialog_datos_widget.dart';

class SideMenu extends StatefulWidget {
  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  PreferenciasUsuario _prefs = PreferenciasUsuario();

  void _showDatos() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogDatosWidget(
          onDelete: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 55),
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navegacion.ir_EditarUsuario(context);
                              },
                              child: Container(
                                width: 50,
                                height: 40,
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      width: 70,
                                      height: 50,
                                      child: CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Color(0XFFCCCCCC),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8),
                                          child: ClipOval(
                                            child: Image.network(
                                              'https://cdn.icon-icons.com/icons2/933/PNG/512/user-shape_icon-icons.com_72487.png',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        width: 14,
                                        height: 14,
                                        decoration: const BoxDecoration(
                                            color: Colors.black,
                                            shape: BoxShape.circle),
                                        child: const Icon(
                                          Icons.edit,
                                          size: 10,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      '${_prefs.usuarioNombre} ${_prefs.usuarioApellidos}',
                                      maxLines: 2,
                                      style: GoogleFonts.openSans(
                                          color: Color(0xff000000),
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      _prefs.usuarioEmail,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.openSans(
                                        color: Color(0xffBCBABE),
                                        fontSize: 13.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                ItemOptionSliderMenu(
                  titulo: 'Perfil',
                  icon: Icons.arrow_forward_ios_rounded,
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditarUsuario()),
                    );
                  }, iconStart: Icons.person,
                ),
                Visibility(
                  visible: false,
                  child: ItemOptionSliderMenu(
                    titulo: 'Tarjetas',
                    icon: Icons.arrow_forward_ios_rounded,
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TabsPage(selectedIndex: 1)),
                      );
                    }, iconStart: Icons.credit_card,
                  ),
                ),
                ItemOptionSliderMenu(
                  titulo: 'Ayuda',
                  icon: Icons.arrow_forward_ios_rounded,
                  onTap: () {
                    Navigator.of(context).pop();
                    _showDatos();
                  }, iconStart: Icons.help_rounded,
                ),
              ],
            ),
            GestureDetector(
              onTap: (){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SplashScreenPage()),
                );


               _prefs.usuarioFechaNacimiento = "";
               _prefs.usuarioApellidos = "";
               _prefs.usuarioNombre = "";
               _prefs.usuarioDni = "";
               _prefs.usuarioEmail = "";
                _prefs.Usuario = "";
                _prefs.usuarioTelefono = "";
                _prefs.logueado = false;
              },
              child: Container(
                height: 40,
                width: 145,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(58),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "Cerrar Sesión",
                    style: GoogleFonts.openSans(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.4),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
