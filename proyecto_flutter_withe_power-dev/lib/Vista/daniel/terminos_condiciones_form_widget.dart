import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_withe_power/Controlador/navegacion.dart';
import 'package:proyecto_withe_power/Vista/daniel/ButtonCardSelection.dart';
import 'package:proyecto_withe_power/Vista/daniel/button_add_remove_widget.dart';

class TerminosCondicionesFormWidget extends StatefulWidget {
  Function onTap;

  TerminosCondicionesFormWidget({required this.onTap});

  @override
  State<TerminosCondicionesFormWidget> createState() =>
      _TerminosCondicionesFormWidgetState();
}

class _TerminosCondicionesFormWidgetState
    extends State<TerminosCondicionesFormWidget> {
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
              Align(
                alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close))),
              Text(
                "Términos y \n condiciones",
                style: GoogleFonts.openSans(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 21,
              ),
              Text(
                "1. Notificaciones",
                style: GoogleFonts.openSans(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "La edad mínima para acceder a la discoteca es de discoteca 18 años. No se admite la re-entrada a la sala con la misma entrada, lista de invitados o pase de temporada. Una vez se salga de la sala habrá que adquirir una entrada nueva. Se permite la entrada a la sala en bañador y chanclas. No se permite la entrada al recinto  descalza/o. Se aconseja siempre tener camiseta y un recambio para la noche. \n El recinto dispone de guarda ropa y taquillas personales en alquiler al publico para dejar las pertenencias. Para cualquier artículo perdido recogido, sé consciente de que solo lo conservaremos durante un plazo máximo de una semana después de que se haya notificado su desaparición, por lo que contacta con nosotros lo antes posible. Todos los artículos encontrados dentro de las instalaciones serán conservados durante 1 semana, después de este plazo todos serán enviados a la Guardia Civil. Puedes contactar con ellos en el 971340502. El servicio básico de primer auxilio esta incluido en el aceso a la sala, pero si los doctores o el equipo de controladores opinen que el cliente no puede quedarse en la sala por motivos médicos y/o comportamentales, dicho cliente tendrá que dejar el recinto y el parking privado del local sin tener derecho a ningúna devolución. A caso que sea traslado por el equipo medico y hospitalizado el mismo cliente se hará cargo de los gastos de hospitalización según las reglas de nuestro colaborador, Galeno Clinic. En caso de lesiones o accidente, dirígete a nuestro personal. Contamos con un socorrista plenamente cualificado a diario para intervenir ante cualquier incidencia médica. Para nuestros eventos más concurridos, contamos con el apoyo del equipo médico local dentro del recinto en caso de cualquier problema. Actúa y bebe con responsabilidad dentro del recinto y mantente hidratado dentro del Day Club, especialmente en temporada alta cuando la incidencia solar es más fuerte." ,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                ),
              ),
              const SizedBox(height: 18.0),
              ButtonCardSelection(
                isIconData: false,
                iconData: Icons.shopping_cart,
                isAmount: false,
                total: "S/0.00",
                texto: "Aceptar",
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
