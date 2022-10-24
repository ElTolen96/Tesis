import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_withe_power/Controlador/navegacion.dart';
import 'package:proyecto_withe_power/Vista/daniel/ButtonCardSelection.dart';
import 'package:proyecto_withe_power/Vista/daniel/button_add_remove_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../Controlador/servicios/api_services.dart';
import '../../Modelo/VentaMP.dart';
import '../../Modelo/Zona.dart';

class CodigoQRWidget extends StatefulWidget {
  String codigoQR;
  Color colorQR;

  CodigoQRWidget({required this.codigoQR, required this.colorQR});

  @override
  State<CodigoQRWidget> createState() => _CodigoQWidgetState();
}

class _CodigoQWidgetState extends State<CodigoQRWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 18.0),
      // padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: const BoxDecoration(
        color: Color(0xfff8f8f8),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          topLeft: Radius.circular(24),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close),),),
              Text(
                "Codigo QR de la Venta",
                style:
                GoogleFonts.openSans(
                    color: const Color(
                        0XFF6A6A6A),
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Center(
                child: QrImage(
                  data: widget.codigoQR,
                  version: QrVersions.auto,
                  foregroundColor: widget.colorQR,
                  size: 200.0,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Código: ",
                    style: GoogleFonts
                        .openSans(
                        color: Color(
                            0XFF6A6A6A),
                        fontSize: 14),
                  ),
                  Text(
                    widget.codigoQR,
                    maxLines: 2,
                    style: GoogleFonts.openSans(
                        color: Color(
                            0XFF6A6A6A),
                        fontSize: 12,
                        fontWeight:
                        FontWeight
                            .bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
