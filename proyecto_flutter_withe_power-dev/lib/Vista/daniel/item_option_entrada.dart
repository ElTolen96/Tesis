import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_withe_power/Vista/daniel/card_entrada.dart';


class ItemOptionEntrada extends StatelessWidget {
  Function onTap;
  DateTime fechaCompleto;
  String zona;
  String dayFecha;
  String monthFecha;
  String codigo;
  String nroEntradas;
  String estado;
  Color colorEstado;
  Color colorTextoEstado;

  ItemOptionEntrada({
    required this.onTap,
    required this.estado,
    required this.colorEstado,
    required this.colorTextoEstado,
    required this.zona,
    required this.dayFecha,
    required this.monthFecha,
    required this.codigo,
    required this.nroEntradas,
    required this.fechaCompleto,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: CouponCard(
        secondChild: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 14),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment:
                CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.center,
                    mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        height: 49,
                        width: 80,
                        decoration: const BoxDecoration(
                          color: Color(0XFF000000),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.token,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                      child: Padding(
                        padding:
                        const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              zona,
                              style:
                              GoogleFonts.openSans(
                                  color: const Color(
                                      0XFF6A6A6A),
                                  fontSize: 12),
                            ),
                            Text(
                              "$dayFecha $monthFecha",
                              style:
                              GoogleFonts.openSans(
                                  color:
                                  Colors.black,
                                  fontSize: 32,
                                  fontWeight:
                                  FontWeight
                                      .bold),
                            ),
                            Row(
                              children: [
                                Text(
                                  "F. Venta: ",
                                  style: GoogleFonts
                                      .openSans(
                                      color: Color(
                                          0XFF6A6A6A),
                                      fontSize: 12),
                                ),
                                Expanded(
                                  child: Text(
                                    '${fechaCompleto.day}-${fechaCompleto.month}-${fechaCompleto.year}',
                                    maxLines: 2,
                                    style: GoogleFonts.openSans(
                                        color: Color(
                                            0XFF6A6A6A),
                                        fontSize: 12,
                                        fontWeight:
                                        FontWeight
                                            .bold),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Cantidad: $nroEntradas Entradas",
                              style:
                              GoogleFonts.openSans(
                                  color: Color(
                                      0XFF6A6A6A),
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      )),
                  Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 80,
                        height: 25,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: colorEstado,
                          borderRadius:
                          BorderRadius.circular(
                              6.0),
                        ),
                        child: Text(
                          estado,
                          style:
                          GoogleFonts.openSans(
                            color:
                            colorTextoEstado,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      GestureDetector(
                        onTap: (){
                          onTap();
                        },
                        child: Container(
                          width: 80,
                          height: 25,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                            BorderRadius.circular(
                                6.0),
                          ),
                          child: Text(
                            "Ver QR",
                            style:
                            GoogleFonts.openSans(
                              color:
                              Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        width: double.infinity,
        backgroundColor: const Color(0XFFFFFFFF),
        decoration: const BoxDecoration(
            color: Color(0XFFFFFFFF),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 12,
                offset: Offset(4, 4),
              ),
            ]),
        curvePosition: 66,
      ),
    );
  }
}
