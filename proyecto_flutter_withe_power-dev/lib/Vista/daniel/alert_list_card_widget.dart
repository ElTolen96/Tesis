import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_withe_power/Controlador/navegacion.dart';
import 'package:proyecto_withe_power/Vista/daniel/ButtonCardSelection.dart';
import 'package:proyecto_withe_power/Vista/daniel/button_add_remove_widget.dart';

class AlertListCardWidget extends StatefulWidget {
  Function onTap;

  AlertListCardWidget({required this.onTap});

  @override
  State<AlertListCardWidget> createState() => _AlertListCardWidgetState();
}

class _AlertListCardWidgetState extends State<AlertListCardWidget> {
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool status = true;

  int quantity = 1;

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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "Asignar tarjeta",
                      style: GoogleFonts.openSans(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close))
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 110,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 4),
                      borderRadius: BorderRadius.circular(14.0),
                      gradient: LinearGradient(colors: [
                        Color(0XFF9D9D9D),
                        Color(0XFFC3C3C3),
                        Color(0XFFE5E4E4),
                      ])),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "...3456",
                                style: GoogleFonts.openSans(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.delete_forever_rounded,
                                color: Colors.black12,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 110,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.0),
                      gradient: LinearGradient(colors: [
                        Color(0XFF0039A7),
                        Color(0XFF2163E3),
                        Color(0XFF89B0FF),
                      ])),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0, right: 12.0, bottom: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/images/card_credit_visa_icon.png",
                          width: 80,
                          height: 60,
                          color: Colors.white,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "...3456",
                                style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.delete_forever_rounded,
                                color: Colors.black12,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: 110,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.0),
                      color: Colors.black12),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0, right: 12.0, bottom: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       Image.asset("assets/images/agregar-propiedad-96.png", width: 45, height: 45,),
                        Text(
                          "Agregar nueva tarjeta",
                          style: GoogleFonts.openSans(
                            color: Colors.black26,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18.0),
              ButtonCardSelection(
                isIconData: false,
                iconData: Icons.shopping_cart,
                isAmount: false,
                total: "S/0.00",
                texto: "Confirmar",
                onTap: () {
                  widget.onTap();
                },
                background: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
