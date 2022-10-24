import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_withe_power/Modelo/Evento.dart';
import 'package:proyecto_withe_power/Vista/daniel/card_detalle_pago.dart';
import 'package:proyecto_withe_power/Vista/daniel/card_entrada.dart';

class ItemDetallePagoEntrada extends StatelessWidget {
  String estado;
  String cantidad;
  String precioPagar;
  String zona;
  Color colorEstado;
  Color colorTextoEstado;
  EventoModel eventoModel;

  ItemDetallePagoEntrada(
      {required this.eventoModel,
      required this.cantidad,
      required this.precioPagar,
      required this.zona,
      required this.estado,
      required this.colorEstado,
      required this.colorTextoEstado});

  @override
  Widget build(BuildContext context) {
    String languageCode = Localizations.localeOf(context).languageCode;
    String formattedDate = DateFormat.MMM(languageCode).format(eventoModel.fecha);
    String mes = formattedDate;

    return CouponDetallePagoCard(
      firstChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Entradas",
                      style: GoogleFonts.openSans(
                          color: Colors.white, fontSize: 12),
                    ),
                    Text(
                      "$cantidad $zona",
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Fecha",
                      style: GoogleFonts.openSans(
                          color: Colors.white, fontSize: 12),
                    ),
                    Row(
                      children: [
                        Text(
                          "${eventoModel.fecha.day}",
                          style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mes,
                              style: GoogleFonts.openSans(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "${eventoModel.fecha.year}",
                              style: GoogleFonts.openSans(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hora",
                      style: GoogleFonts.openSans(
                          color: Colors.white, fontSize: 12),
                    ),
                    Text(
                      eventoModel.hora,
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      width: double.infinity,
      backgroundColor: Colors.white12,
      decoration: BoxDecoration(color: Colors.white12, boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 12,
          offset: Offset(4, 4),
        ),
      ]),
      curvePosition: 66,
      secondChild: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Monto a pagar",
                textAlign: TextAlign.right,
                style: GoogleFonts.openSans(color: Colors.white, fontSize: 12),
              ),
              Text(
                "S/ $precioPagar",
                style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
