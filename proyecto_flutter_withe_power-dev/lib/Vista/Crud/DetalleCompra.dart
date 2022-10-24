import 'package:culqi_flutter/culqi_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mpcheckout/mpcheckout.dart';
import 'package:proyecto_withe_power/Controlador/navegacion.dart';
import 'package:proyecto_withe_power/Modelo/Envio_venta.dart';
import 'package:proyecto_withe_power/Modelo/Evento.dart';
import 'package:proyecto_withe_power/Modelo/Mensajes.dart';
import 'package:proyecto_withe_power/Modelo/Venta.dart';
import 'package:proyecto_withe_power/Modelo/Zona.dart';
import 'package:proyecto_withe_power/Vista/daniel/ButtonCardSelection.dart';
import 'package:proyecto_withe_power/Vista/daniel/alert_confirmar_pago_widget.dart';
import 'package:proyecto_withe_power/Vista/daniel/alert_list_card_widget.dart';
import 'package:proyecto_withe_power/Vista/daniel/general_widget.dart';
import 'package:proyecto_withe_power/Vista/daniel/item_option_detalle_entrada.dart';
import 'package:proyecto_withe_power/Vista/daniel/terminos_condiciones_form_widget.dart';
import '../../Controlador/preferencias_usuario.dart';
import '../../Controlador/servicios/api_services.dart';
import '../../Controlador/servicios/constants.dart' as globals;
import '../../Modelo/Persona.dart';
import '../../Modelo/VentaMP.dart';
import '../daniel/confirmar_pago_widget.dart';

class DetalleCompra extends StatefulWidget {
  static final String routeName = Mensajes.RUTA_DETALLECOMPRA;
  final EventoModel eventoModel;
  final ZonaModel zona;
  final double precioUnitario;
  final int nroEntradas;

  const DetalleCompra(
      {required this.eventoModel,
      required this.zona,
      required this.precioUnitario,
      required this.nroEntradas});

  @override
  _DetalleCompraState createState() => _DetalleCompraState();
}

class _DetalleCompraState extends State<DetalleCompra> {
  bool status = false;
  final _formTarjetaKey = GlobalKey<FormState>();
  double montoTotalPagar = 0.0;
  String idUsuario = "", email = "";
  int nroOperacion = 0;
  PreferenciasUsuario _prefs = PreferenciasUsuario();
  List<PersonaModel> perfilModel = [];

  @override
  void initState() {
    super.initState();
    idUsuario = _prefs.IdUsuario;
    getListarUsuario(idUsuario);
    montoTotalPagar = widget.nroEntradas * widget.precioUnitario;
  }

  getListarUsuario(String idUsuario) async {
    _apiServices.getListarUsuarioEspecifico(idUsuario).then((value) {
      perfilModel = value;
      email = perfilModel.first.email;
      setState(() {});
    });
  }

  Future<void> ejecutarMercadoPago(BuildContext contexto) async {
    var mp = Mpcheckout.initialize(
        clientID: globals.mpClientID,
        publicKey: globals.mpPublicKey,
        accesToken: globals.mpAccessToken);

    final Preference _pref = Preference(
      statementDescriptor: 'Pago de Entradas a la discoteca',
      additionalInfo: 'White Power',
      items: [
        Item(
            title: 'Pago de  Entradas',
            quantity: widget.nroEntradas,
            //unitPrice: 2,
            unitPrice: widget.precioUnitario,
            currencyId: "PEN",
            description: "Pago de Entradas ${widget.zona.nombre}"),
      ],
      paymentMethods: PaymentMethods(
        excludedPaymentTypes: [
          ExcludedPaymentTypes(id: 'ticket'),
          ExcludedPaymentTypes(id: 'atm'),
        ],
      ),
      payer: Payer(
        email: email,
      ),
    );

    try {
      final result = await mp.startCheckout(_pref);
      if (result.status == 'rejected') {
        print("RESULTADO RECHAZADO-------- $result");
        print(result.status);
        ScaffoldMessenger.of(contexto).showSnackBar(
          SnackBar(
            content: Text('Rejected'),
            backgroundColor: Colors.red,
          ),
        );
      }
      print(result.id); //NRO DE OPERACION
      print(result.status); // approved
      print(result.result); //done
      print(result.paymentMethodId); //debvisa
      print(result.paymentTypeId); //debit_card
      print(result.statusDetail); //accredited
      print(result.transactionAmount); //2

      nroOperacion = result.id!;

      if (result.status == 'approved') {
        nroOperacion = result.id!;
        VentaMpModel ventaMpModel = VentaMpModel(
            idUsuario: int.parse(idUsuario),
            idTarjeta: 1,
            idZona: int.parse(widget.zona.idZona),
            monto: montoTotalPagar.toInt(),
            codigoQr: nroOperacion.toString(),
            token: "",
            idEvento: int.parse(widget.eventoModel.idEvento),
            entradas: widget.nroEntradas,
            precioUnitario: widget.precioUnitario.toInt());
        postRealizarVenta(ventaMpModel);
      }
    } on MpException catch (error) {
      print("ERROR -------- ${error.message}");
      //print(error.message);
    }
  }

  bool isLoading = false;
  final APIServices _apiServices = APIServices();

  Future<void> generarPago() async {
    CCard card = CCard(
        cardNumber: nroTarjetaController.text,
        expirationMonth:
            int.parse(expiredDateTarjetaController.text.substring(0, 2)),
        expirationYear:
            int.parse(expiredDateTarjetaController.text.substring(3, 5)),
        cvv: cvvTarjetaController.text,
        email: mailController.text);

    try {
      if (card.isCardNumberValid() &&
          card.isExpirationDateValid() &&
          card.isCcvValid() &&
          card.isEmailValid()) {
        CToken token =
            await createToken(card: card, apiKey: "pk_test_ea76510138aa4f57");
        //su token
        print(token.id);
        print(token);
        EnvioVentaModel envioVentaModel = EnvioVentaModel(
            amount: "1",
            currencyCode: "PEN",
            email: mailController.text,
            sourceId: token.id!);
        // postRealizarVenta(envioVentaModel);

      }
    } on CulqiBadRequestException catch (ex) {
      print(ex.cause);
    } on CulqiUnknownException catch (ex) {
      //codigo de error del servidor
      print(ex.cause);
    }
  }

  postRealizarVenta(VentaMpModel ventaMpModel) {
    _apiServices.postRegistrarVenta(ventaMpModel).then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (contexto) => ConfirmarPagoWidget(
                    ventaMpModel: ventaMpModel,
                    zona: widget.zona.nombre,
                  )));

      setState(() {});
    });
  }

  showTerminosCondicionesCardForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.black.withOpacity(0.8),
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          // padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: TerminosCondicionesFormWidget(
            onTap: () {
              status = true;
              Navigator.pop(context);
              setState(() {});
            },
          ),
        );
      },
    );
  }

  showOpenCardForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.black.withOpacity(0.8),
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          // padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: AlertListCardWidget(
            onTap: () {
              Navigator.pop(context);
              //showConfirmarPagoForm(context);
            },
          ),
        );
      },
    );
  }

  showConfirmarPagoForm(BuildContext context, VentaMpModel ventaMpModel) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.black.withOpacity(0.8),
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          // padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: AlertConfirmarPagoWidget(
            ventaMpModel: ventaMpModel,
            onTap: () {
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  //TextEditingController nroTarjetaController = TextEditingController();
  var nroTarjetaController = MaskedTextController(mask: '0000 0000 0000 0000');
  var expiredDateTarjetaController = MaskedTextController(mask: '00/00');
  //TextEditingController expiredDateTarjetaController = TextEditingController();
  TextEditingController cvvTarjetaController = TextEditingController();
  TextEditingController titularTarjetaController = TextEditingController();
  TextEditingController mailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: double.infinity,
              height: 310,
              decoration: BoxDecoration(
                color: Color(0xFF000000),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navegacion.ir_Inicio(context);
                      },
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      "Detalle de las entradas",
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ItemDetallePagoEntrada(
                      estado: "Disponible",
                      precioPagar: montoTotalPagar.toString(),
                      cantidad: widget.nroEntradas.toString(),
                      eventoModel: widget.eventoModel,
                      colorEstado: Color(0XFFEBFAF0),
                      colorTextoEstado: Color(0XFF2C682E),
                      zona: widget.zona.nombre,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    /*
                    ButtonCardSelectionOption(
                      isIconData: false,
                      isIconDataRight: true,
                      texto: "···· 3456",
                      onTap: () {},
                      background: Colors.white,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ButtonCardSelectionOption(
                      isIconData: true,
                      iconData: Icons.add_circle_rounded,
                      isIconDataRight: false,
                      texto: "Agregar tarjeta",
                      onTap: () {},
                      background: Colors.white,
                    ),

                     */
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          activeColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.0),
                          ),
                          value: status,
                          onChanged: (bool? value) {
                            status = value!;
                            setState(() {});
                          },
                        ),
                        Row(
                          children: [
                            Text(
                              "Al comprar aceptas los ",
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.4),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showTerminosCondicionesCardForm(context);
                              },
                              child: const Text(
                                "Términos y condiciones",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Color(0xff4760FF),
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
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ButtonCardSelection(
                  isIconData: false,
                  isAmount: false,
                  texto: "Realizar Pago",
                  onTap: () {
                    if (status == false) {
                      messageSuccessInfoSnackBar(
                          context, "Debe aceptar los terminos y condiciones");
                    } else {
                      //generarPago();
                      //ejecutarMercadoPago(1, 1, "daniel puicon", "daniel@gmail.com");
                      ejecutarMercadoPago(context);
                    }

                    //showOpenCardForm(context);
                  },
                  background: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
