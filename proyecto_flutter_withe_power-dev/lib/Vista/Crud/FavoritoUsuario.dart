import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_withe_power/Modelo/Mensajes.dart';
import 'package:proyecto_withe_power/Vista/daniel/favorite_item.dart';

import '../../Controlador/db/db_white_power.dart';
import '../../Controlador/servicios/api_services.dart';
import '../../Modelo/Evento.dart';

class FavoritoUsuario extends StatefulWidget {
  static final String routeName = Mensajes.RUTA_FAVORITOUSUARIO;
  FavoritoUsuario({Key? key});

  @override
  _FavoritoUsuarioState createState() => _FavoritoUsuarioState();
}

class _FavoritoUsuarioState extends State<FavoritoUsuario> {
  final APIServices _apiServices = APIServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
              Text(
                "Mis Favoritos",
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold, fontSize: 28),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Conoce los eventos que guardaste como favoritos.",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.openSans(
                  color: Colors.black38,
                ),
              ),
              FutureBuilder(
                future: DBWhitePower.db.getEventosFavourites(),
                builder:
                    (BuildContext context, AsyncSnapshot snap) {
                  if (snap.hasData) {
                    List<EventoModel> eventos  = snap.data;
                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: eventos.length,
                        itemBuilder: (BuildContext context, int itemIndex) {
                          return FavoriteItem(aforo: eventos[itemIndex].aforo,
                            fecha:  '${eventos[itemIndex].fecha.day}-${eventos[itemIndex].fecha.month}-${eventos[itemIndex].fecha.year}',
                            titulo: eventos[itemIndex].titulo,
                            UrlImagen: eventos[itemIndex].urlImagen,
                            descripcion: eventos[itemIndex].descripcion,
                            hora: eventos[itemIndex].hora,
                            favorito: Color(0XFF4760FF),
                            backgroundfavorito: const Color(0XFFDADFFE),
                          onTapFavorito: (){

                          },);
                        });
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
