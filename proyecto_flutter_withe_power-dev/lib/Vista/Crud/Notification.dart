import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_withe_power/Controlador/navegacion.dart';
import 'package:proyecto_withe_power/Modelo/Mensajes.dart';
import 'package:proyecto_withe_power/Modelo/Notificacion.dart';

import '../../Controlador/db/db_white_power.dart';
import '../../Controlador/preferencias_usuario.dart';
import '../../Controlador/servicios/api_services.dart';

class NotificarUsuario extends StatefulWidget {
  static final String routeName = Mensajes.RUTA_NOTIFICARUSUARIO;

  NotificarUsuario({Key? key});

  @override
  _NotificarUsuarioState createState() => _NotificarUsuarioState();
}

class _NotificarUsuarioState extends State<NotificarUsuario> {
  PreferenciasUsuario _preferenciasUsuario = PreferenciasUsuario();

  List<String> listItems = [
    "One",
    "Two",
    "Three",
    "Four",
    "One",
    "Two",
    "Three",
    "Four",
  ]; //dummy list of items

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataNotificaciones(_preferenciasUsuario.IdUsuario);
  }

  void deleteItem(index) {
    setState(() {
      listItems.removeAt(index);
    });
  }

  void undoDeletion(index, item) {
    setState(() {
      listItems.insert(index, item);
    });
  }

  bool isLoading = false;
  final APIServices _apiServices = APIServices();

  getDataNotificaciones(String idUsuario) async {
    isLoading = true;
    _apiServices.getNotificaciones(idUsuario).then((value) {
      // eventos = value;

      for (var element in value) {
        DBWhitePower.db.insertAllNotificacionRaw(element);
        DBWhitePower.db.updateNotificacion(element);
      }
      isLoading = false;
      setState(() {});
    });
  }

  Future<void> confirmarLectura(String? idNotificacion) async {
    print(idNotificacion);
    await DBWhitePower.db.updateLecturaNotificacion(idNotificacion);
    setState(() {});
  }

  Future<void> eliminarNotificacion(String? idNotificacion) async {
    print(idNotificacion);
    await DBWhitePower.db.deleteNotificacion(idNotificacion);
    setState(() {});
  }

  Widget secondarystackBehindDismiss() {
    return Container(
      color: Color(0XFFFF3B30),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('Eliminar',
                style: GoogleFonts.openSans(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget stackBehindDismiss() {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Text('Leída',
                style: GoogleFonts.openSans(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navegacion.ir_Inicio(context);
                },
                child: Icon(Icons.arrow_back_rounded),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Mis notificaciones",
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold, fontSize: 24),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Nuevas",
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(
                height: 300,
                child: FutureBuilder(
                  future: DBWhitePower.db.getNotificaciones(),
                  builder: (BuildContext context, AsyncSnapshot snap) {
                    if (snap.hasData) {
                      List<NotificacionModel> notificaciones = snap.data;
                      return notificaciones.isNotEmpty
                          ? ListView.builder(
                              itemCount: notificaciones.length,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Dismissible(
                                  background: stackBehindDismiss(),
                                  key: ObjectKey(notificaciones[index]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: ItemNoticacion(
                                      descripcion:
                                          notificaciones[index].descripcion,
                                      fecha:
                                          '${notificaciones[index].fechaVenta.day}-${notificaciones[index].fechaVenta.month}-${notificaciones[index].fechaVenta.year} a las ${notificaciones[index].fechaVenta.hour}:${notificaciones[index].fechaVenta.minute}',
                                    ),
                                  ),
                                  onDismissed: (direction) {
                                    confirmarLectura(
                                        notificaciones[index].idNotificacion);
                                    notificaciones.removeAt(index);
                                  },
                                  confirmDismiss:
                                      (DismissDirection direction) async {
                                    return await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("CONFIRMAR"),
                                          content: Text("Estas seguro que quieres confirmar la lectura de esta notifacion?"),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(true),
                                              child: Text("CONFIRMAR"),
                                            ),
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(false),
                                              child: const Text("CANCELAR"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            )
                          : Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12.withOpacity(0.08),
                                    blurRadius: 12,
                                    offset: Offset(4, 4),
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text("No hay notificaciones"),
                              ),
                            );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Leídas",
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(
                height: 280,
                child: FutureBuilder(
                  future: DBWhitePower.db.getNotificacionesLeidas(),
                  builder: (BuildContext context, AsyncSnapshot snap) {
                    if (snap.hasData) {
                      List<NotificacionModel> notificacionesLeidas = snap.data;
                      return notificacionesLeidas.isNotEmpty
                          ? ListView.builder(
                              itemCount: notificacionesLeidas.length,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Dismissible(
                                  background: secondarystackBehindDismiss(),
                                  key: ObjectKey(notificacionesLeidas[index]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12
                                                  .withOpacity(0.08),
                                              blurRadius: 12,
                                              offset: Offset(4, 4),
                                            ),
                                          ]),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  width: 48,
                                                  height: 48,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: Color(0XFF000000)
                                                        .withOpacity(0.4),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: IconButton(
                                                    padding: EdgeInsets.zero,
                                                    icon: const Icon(
                                                      Icons
                                                          .notifications_active_outlined,
                                                      size: 22,
                                                      color: Colors.white,
                                                    ),
                                                    onPressed: () {},
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${notificacionesLeidas[index].fechaVenta.day}-${notificacionesLeidas[index].fechaVenta.month}-${notificacionesLeidas[index].fechaVenta.year} a las ${notificacionesLeidas[index].fechaVenta.hour}:${notificacionesLeidas[index].fechaVenta.minute}',
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          GoogleFonts.openSans(
                                                        fontSize: 12.0,
                                                        color:
                                                            Color(0XFF999999),
                                                      ),
                                                    ),
                                                    Text(
                                                      notificacionesLeidas[
                                                              index]
                                                          .descripcion,
                                                      style:
                                                          GoogleFonts.openSans(
                                                              color: Color(
                                                                      0xff000000)
                                                                  .withOpacity(
                                                                      0.6),
                                                              fontSize: 16.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                    /*
                                              Text(
                                                "Este sábado 20 de Julio",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.openSans(
                                                  color: Color(0xff000000)
                                                      .withOpacity(0.4),
                                                  fontSize: 13.0,
                                                ),
                                              ),
                                              */
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  onDismissed: (direction) {
                                    eliminarNotificacion(
                                        notificacionesLeidas[index]
                                            .idNotificacion);
                                    notificacionesLeidas.removeAt(index);
                                  },
                                  confirmDismiss:
                                      (DismissDirection direction) async {
                                    return await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("ELIMINAR"),
                                          content: Text(
                                              "Estas seguro que deseas eliminar esta notificacion?"),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(true),
                                              child: Text("ELIMINAR"),
                                            ),
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(false),
                                              child: const Text("CANCELAR"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            )
                          : Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12.withOpacity(0.08),
                                    blurRadius: 12,
                                    offset: Offset(4, 4),
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text("No hay notificaciones"),
                              ),
                            );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemNoticacion extends StatelessWidget {
  String descripcion;
  String fecha;

  ItemNoticacion({
    required this.descripcion,
    required this.fecha,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.08),
              blurRadius: 12,
              offset: Offset(4, 4),
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color(0XFF4760FF),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.notifications_active_outlined,
                      size: 22,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fecha,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.openSans(
                        fontSize: 12.0,
                        color: const Color(0XFF999999),
                      ),
                    ),
                    Text(
                      descripcion,
                      style: GoogleFonts.openSans(
                          color: const Color(0xff000000),
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Compra exitosa",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.openSans(
                        color: Color(0xff000000),
                        fontSize: 13.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
