import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_withe_power/Controlador/navegacion.dart';
import 'package:proyecto_withe_power/Modelo/Evento.dart';
import 'package:proyecto_withe_power/Modelo/Zona.dart';
import 'package:proyecto_withe_power/Vista/daniel/ButtonCardSelection.dart';
import 'package:proyecto_withe_power/Vista/daniel/button_add_remove_widget.dart';

import '../Crud/DetalleCompra.dart';

class AddCartFormWidget extends StatefulWidget {
  final EventoModel eventoModel;
  final String title;
  final ZonaModel zona;
  final String monto;
  final bool type;
  final String collection;
  Function onTap;

  AddCartFormWidget({
    required this.eventoModel,
    required this.zona,
    required this.title,
    required this.monto,
    required this.type,
    required this.collection,
    required this.onTap
  });

  @override
  State<AddCartFormWidget> createState() => _AddCartFormWidgetState();
}

class _AddCartFormWidgetState extends State<AddCartFormWidget> {
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool status = true;

  double montoTotal = 0.0;
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 18.0),
      // padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      height: 280,
      decoration: const BoxDecoration(
        color: Color(0xfff8f8f8),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          topLeft: Radius.circular(24),
        ),
      ),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8,),
              Text(
                "Aquiere tus entradas para la zona VIP",
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xffF0F0F0),
                    borderRadius: BorderRadius.circular(16.0)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "VIP  S/ ${widget.monto}",
                            style: GoogleFonts.openSans(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                         Row(
                           children: [
                             ButtonAddRemoveWidget(
                                 icon: Icons.remove,
                                 onPressed: () {
                                   if (quantity > 1) {
                                     quantity--;
                                     setState(() {});
                                   }
                                 }),
                             SizedBox(
                               width: 8,
                             ),
                             Container(
                               width: 30,
                               alignment: Alignment.center,
                               child: Text(
                                 quantity.toString(),
                                 style: TextStyle(
                                     color: Colors.black,
                                     fontWeight: FontWeight.bold,
                                     fontSize: 22.0),
                               ),
                             ),
                             SizedBox(
                               width: 8,
                             ),
                             ButtonAddRemoveWidget(
                               icon: Icons.add,
                               onPressed: () {
                                 quantity++;
                                 setState(() {});
                               },
                             ),
                           ],
                         )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18.0),
              ButtonCardSelection(
                isIconData: false,
                iconData: Icons.shopping_cart,
                isAmount: false,
                total: "S/0.00",
                texto: "Seleccionar",
                onTap: (){
                  montoTotal = quantity * double.parse(widget.eventoModel.zonaVip);
                  setState(() {

                  });
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      builder: (context) => DetalleCompra(eventoModel: widget.eventoModel, zona: widget.zona, precioUnitario: double.parse(widget.eventoModel.zonaVip), nroEntradas: quantity,)), (router) => false);
                }, background: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
