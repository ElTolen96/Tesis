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

class AlertConfirmarPagoWidget extends StatefulWidget {
  Function onTap;
  VentaMpModel ventaMpModel;

  AlertConfirmarPagoWidget({required this.onTap, required this.ventaMpModel});

  @override
  State<AlertConfirmarPagoWidget> createState() => _AlertConfirmarPagoWidgetState();
}

class _AlertConfirmarPagoWidgetState extends State<AlertConfirmarPagoWidget> {
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
      isLoading = false;
      setState(() {
        print(zonaModel.first.nombre);
      });
    });
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close))),

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
                  zonaModel.first.nombre,
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
                    widget.onTap();
                  },
                  background: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: GestureDetector(
                  onTap: () {
                    Navegacion.ir_Inicio(context);
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
      ),
    );
  }
}
