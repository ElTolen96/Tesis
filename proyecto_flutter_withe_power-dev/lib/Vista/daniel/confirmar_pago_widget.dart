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
import '../Crud/TabsPage.dart';

class ConfirmarPagoWidget extends StatefulWidget {
  VentaMpModel ventaMpModel;
  String zona;

  ConfirmarPagoWidget({ required this.ventaMpModel, required this.zona});

  @override
  State<ConfirmarPagoWidget> createState() => _ConfirmarPagoWidgetWidgetState();
}

class _ConfirmarPagoWidgetWidgetState extends State<ConfirmarPagoWidget> {
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool status = true;
  double montoTotal = 0.0;
  int quantity = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    montoTotal = widget.ventaMpModel.precioUnitario.toDouble() * widget.ventaMpModel.entradas;
    getListarZona(widget.ventaMpModel.idZona.toString());
  }
  bool isLoading = false;
  final APIServices _apiServices = APIServices();
  List<ZonaModel> zonaModel = [];
  getListarZona(String idZona){
    isLoading = true;
    _apiServices.getZona(idZona).then((value) {
      zonaModel = value;
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Compra realizada",
              style: GoogleFonts.openSans(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12,),
            Text(
              "Muestra el código QR al momento de ingresar al local.",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.openSans(
                  color: Colors.black.withOpacity(0.4),
                  fontSize: 14.0,)
            ),
            Center(
              child: QrImage(
                data: widget.ventaMpModel.codigoQr,
                version: QrVersions.auto,
                size: 200.0,
              ),
            ),
            SizedBox(height: 12,),
            Center(
              child: Text(
                widget.zona,
                style: GoogleFonts.openSans(
                    color: Colors.black,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(
                "${widget.ventaMpModel.entradas} Entradas",
                style: GoogleFonts.openSans(
                    color: Colors.black.withOpacity(0.4),
                    fontSize: 14.0,),
              ),
            ),
            Center(
              child: Text(
                "Código: ${widget.ventaMpModel.codigoQr}",
                style: GoogleFonts.openSans(
                    color: Colors.black.withOpacity(0.4),
                    fontSize: 14.0,
                ),
              ),
            ),

            const SizedBox(height: 18.0),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ButtonCardSelection(
                isIconData: false,
                iconData: Icons.shopping_cart,
                isAmount: false,
                total: "S/ $montoTotal",
                texto: "Finalizar",
                onTap: () {
                  Navegacion.ir_Inicio(context);
                },
                background: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      builder: (context) => TabsPage(selectedIndex: 1)), (router) => false);
                },
                child: Container(
                  width: double.infinity,
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
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    "Ver mis entradas",
                                    style: GoogleFonts.openSans(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
