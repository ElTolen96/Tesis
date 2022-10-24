import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_withe_power/Modelo/Entrada.dart';
import 'package:proyecto_withe_power/Modelo/Mensajes.dart';
import 'package:proyecto_withe_power/Vista/daniel/container_clippath_entrada.dart';
import 'package:proyecto_withe_power/Vista/daniel/card_entrada.dart';
import 'package:proyecto_withe_power/Vista/daniel/item_option_entrada.dart';
import 'package:proyecto_withe_power/Vista/daniel/tab_bar_entrada.dart';

import '../../Controlador/db/db_white_power.dart';
import '../../Controlador/preferencias_usuario.dart';
import '../../Controlador/servicios/api_services.dart';
import '../daniel/codigoqr_widget.dart';

class EntradaUsuario extends StatefulWidget {
  static final String routeName = Mensajes.RUTA_ENTRADARUSUARIO;

  EntradaUsuario({Key? key});

  @override
  _EntradaUsuarioState createState() => _EntradaUsuarioState();
}

class _EntradaUsuarioState extends State<EntradaUsuario>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final APIServices _apiServices = APIServices();
  bool isLoading = false;
  String idUsuario = "";
  PreferenciasUsuario _prefs = PreferenciasUsuario();

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(vsync: this, length: 3);
    super.initState();
    idUsuario = _prefs.IdUsuario;
    getDataEntradas(idUsuario);
  }

  List<EntradaModel> entradas = [];
  List<EntradaModel> entradasDisponibles = [];
  List<EntradaModel> entradasExpiradas = [];

  getDataEntradas(String idUsuario) async {
    isLoading = true;
    _apiServices.getEntradas(idUsuario).then((value) {
      // eventos = value;
      entradas = value;

      for (var element in value) {
        if (element.flag == "1") {
          entradasDisponibles.add(element);
        }
        if (element.flag == "0") {
          entradasExpiradas.add(element);
        }
      }

      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Mis entradas",
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold, fontSize: 28),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Encuentra aquí toda la información referente a tus entradas.",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.openSans(
                  color: Colors.black38,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 590,
                child: Scaffold(
                  body: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TabBar(
                          unselectedLabelColor: Colors.black,
                          labelColor: Colors.black,
                          indicatorColor: Colors.black,
                          physics: BouncingScrollPhysics(),
                          tabs: const [
                            Tab(
                              text: "Todos",
                            ),
                            Tab(text: "Disponibles"),
                            Tab(text: "Expirados"),
                          ],
                          controller: _tabController,
                          indicatorSize: TabBarIndicatorSize.tab,
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            physics: BouncingScrollPhysics(),
                            children: [
                              _buildListTodos(
                                  key: "key1",
                                  string: "List1: ",
                                  entrada: entradas),
                              _buildListDisponible(
                                  key: "key2",
                                  string: "List2: ",
                                  entrada: entradasDisponibles),
                              _buildListExpirados(
                                  key: "key3",
                                  string: "List3: ",
                                  entrada: entradasExpiradas),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

showConfirmarPagoForm(BuildContext context, String codigoQR, String estado) {
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
        child: CodigoQRWidget(
          codigoQR: codigoQR,
          colorQR: estado == "1" ? Colors.green : Colors.red,
        ),
      );
    },
  );
}

Widget _buildListTodos(
    {required String key,
    required String string,
    required List<EntradaModel> entrada}) {
  return ListView.builder(
    shrinkWrap: true,
    physics: BouncingScrollPhysics(),
    key: PageStorageKey(key),
    itemCount: entrada.length,
    itemBuilder: (BuildContext context, int index) {
      String languageCode = Localizations.localeOf(context).languageCode;
      String formattedDate =
          DateFormat.MMM(languageCode).format(entrada[index].fechaVenta);
      String mes = formattedDate;

      return ItemOptionEntrada(
        estado: entrada[index].flag == "1" ? "Disponible" : "Expirado",
        colorEstado: entrada[index].flag == "1" ? Color(0XFFEBFAF0) : Color(0XFFFF453A).withOpacity(0.22),
        colorTextoEstado: entrada[index].flag == "1" ? Color(0XFF2C682E) : Color(0XFFFF453A),
        zona: entrada[index].zona,
        dayFecha: entrada[index].fechaVenta.day.toString(),
        monthFecha: mes,
        codigo: entrada[index].codigoQr,
        nroEntradas: entrada[index].numeroEntradas,
        onTap: () {
          showConfirmarPagoForm(context, entrada[index].codigoQr, entrada[index].flag);
        },
        fechaCompleto: entrada[index].fechaVenta,
      );
    },
  );
}

Widget _buildListDisponible(
    {required String key,
    required String string,
    required List<EntradaModel> entrada}) {
  return ListView.builder(
    shrinkWrap: true,
    physics: BouncingScrollPhysics(),
    key: PageStorageKey(key),
    itemCount: entrada.length,
    itemBuilder: (BuildContext context, int index) {
      String languageCode = Localizations.localeOf(context).languageCode;
      String formattedDate =
          DateFormat.MMM(languageCode).format(entrada[index].fechaVenta);
      String mes = formattedDate;

      return ItemOptionEntrada(
        estado: "Disponible",
        colorEstado: Color(0XFFEBFAF0),
        colorTextoEstado: Color(0XFF2C682E),
        zona: entrada[index].zona,
        dayFecha: entrada[index].fechaVenta.day.toString(),
        monthFecha: mes,
        codigo: entrada[index].codigoQr,
        nroEntradas: entrada[index].numeroEntradas,
        onTap: () {
          showConfirmarPagoForm(context, entrada[index].codigoQr, entrada[index].flag);
        },
        fechaCompleto: entrada[index].fechaVenta,
      );
    },
  );
}

Widget _buildListExpirados(
    {required String key,
    required String string,
    required List<EntradaModel> entrada}) {
  return ListView.builder(
    shrinkWrap: true,
    physics: BouncingScrollPhysics(),
    key: PageStorageKey(key),
    itemCount: entrada.length,
    itemBuilder: (BuildContext context, int index) {
      String languageCode = Localizations.localeOf(context).languageCode;
      String formattedDate =
          DateFormat.MMM(languageCode).format(entrada[index].fechaVenta);
      String mes = formattedDate;

      return ItemOptionEntrada(
        estado: "Expirado",
        colorEstado: Color(0XFFFF453A).withOpacity(0.22),
        colorTextoEstado: Color(0XFFFF453A),
        zona: entrada[index].zona,
        dayFecha: entrada[index].fechaVenta.day.toString(),
        monthFecha: mes,
        codigo: entrada[index].codigoQr,
        nroEntradas: entrada[index].numeroEntradas,
        onTap: () {
          showConfirmarPagoForm(context,entrada[index].codigoQr, entrada[index].flag);
        }, fechaCompleto: entrada[index].fechaVenta,
      );
    },
  );
}
