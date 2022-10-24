import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_withe_power/Controlador/navegacion.dart';
import 'package:proyecto_withe_power/Modelo/Evento.dart';
import 'package:proyecto_withe_power/Vista/Crud/SideMenu.dart';
import 'package:proyecto_withe_power/Vista/daniel/app_bar_menu_widget.dart';
import 'package:proyecto_withe_power/Vista/daniel/favorite_item.dart';
import 'package:proyecto_withe_power/Vista/daniel/item_option_zona.dart';
import 'package:proyecto_withe_power/Vista/daniel/search_text.dart';

import '../../Controlador/db/db_white_power.dart';
import '../../Controlador/servicios/api_services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TabController tabController;
  final APIServices _apiServices = APIServices();
  bool isLoading = false;

  TextEditingController buscarEventoController = TextEditingController();
  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DBWhitePower.db.initDB();
    buscarEventoController.addListener(() async {
      if (buscarEventoController.text.isNotEmpty) {
        changedEvento(buscarEventoController.text);
      } else {
        eventos = await DBWhitePower.db.getEventos();
      }
    });
    getDataEventos();
    // getAllEventos();
  }

  List<EventoModel> eventos = [];
  List<EventoModel> eventosAux = [];

  getDataEventos() async {
    isLoading = true;
    _apiServices.getEventos().then((value) {
      // eventos = value;
      for (var element in value) {
        print(element.titulo);
        DBWhitePower.db.insertAllEventoRaw(element);
        DBWhitePower.db.updateEvento(element);
      }

      setState(() {
        isLoading = false;
      });
    });
  }

  Future<void> getAllEventos() async {
    eventosAux = await DBWhitePower.db.getEventos();
    setState(() {});
  }

  changedEvento(String evento) {
    isLoading = true;

    //eventos = eventosAux;
    eventos = eventos
        .where((element) =>
            element.titulo.toLowerCase().contains(evento.toLowerCase()))
        .toList();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> addORDeleteFavourite(String? idEvento, String result) async {
    print(idEvento);
    print("hola");
    print(result);
    result == "false" || result.isEmpty
        ? await DBWhitePower.db.updateIsFavouriteEvento(idEvento)
        : await DBWhitePower.db.updateIsNotFavouriteEvento(idEvento);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final CarouselController _controller = CarouselController();

    return Scaffold(
        drawer: SideMenu(),
        body: Stack(
          children: [
            Container(
              height: 306,
              decoration: BoxDecoration(
                color: Color(0XFF1A1A1A),
              ),
            ),
            Positioned(
              top: 185,
              left: 0,
              right: 0,
              child: isLoading
                  ? Container(
                      color: Colors.white60,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Column(
                      children: [
                        buscarEventoController.text.isEmpty
                            ? FutureBuilder(
                                future: DBWhitePower.db.getEventos(),
                                builder:
                                    (BuildContext context, AsyncSnapshot snap) {
                                  if (snap.hasData) {
                                    eventos = snap.data;
                                    return CarouselSlider.builder(
                                      itemCount: eventos.length,
                                      itemBuilder: (BuildContext context,
                                              int itemIndex,
                                              int pageViewIndex) =>
                                          FavoriteItem(
                                        aforo: eventos[itemIndex].aforo,
                                        fecha:
                                            '${eventos[itemIndex].fecha.day}-${eventos[itemIndex].fecha.month}-${eventos[itemIndex].fecha.year}',
                                        titulo: eventos[itemIndex].titulo,
                                        UrlImagen: eventos[itemIndex].urlImagen,
                                        descripcion:
                                            eventos[itemIndex].descripcion,
                                        hora: eventos[itemIndex].hora,
                                        favorito: eventos[itemIndex].favorito ==
                                                "true"
                                            ? Color(0XFF4760FF)
                                            : Colors.black,
                                        backgroundfavorito: eventos[itemIndex]
                                                    .favorito ==
                                                "true"
                                            ? Color(0XFFDADFFE)
                                            : Colors.black.withOpacity(0.09),
                                        onTapFavorito: () {
                                          addORDeleteFavourite(
                                              eventos[itemIndex].idEvento,
                                              eventos[itemIndex].favorito!);
                                        },
                                      ),
                                      options: CarouselOptions(
                                        autoPlay: true,
                                        height: 200,
                                        onPageChanged: (index, reason) {
                                          setState(
                                            () {
                                              _currentIndex = index;
                                            },
                                          );
                                        },
                                      ),
                                    );
                                  }
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              )
                            : eventos.isNotEmpty
                                ? CarouselSlider.builder(
                                    itemCount: eventos.length,
                                    itemBuilder: (BuildContext context,
                                            int itemIndex, int pageViewIndex) =>
                                        FavoriteItem(
                                      aforo: eventos[itemIndex].aforo,
                                      fecha:
                                          '${eventos[itemIndex].fecha.day}-${eventos[itemIndex].fecha.month}-${eventos[itemIndex].fecha.year}',
                                      titulo: eventos[itemIndex].titulo,
                                      UrlImagen: eventos[itemIndex].urlImagen,
                                      descripcion:
                                          eventos[itemIndex].descripcion,
                                      hora: eventos[itemIndex].hora,
                                      favorito:
                                          eventos[itemIndex].favorito == "true"
                                              ? const Color(0XFF4760FF)
                                              : Colors.black,
                                      backgroundfavorito:
                                          eventos[itemIndex].favorito == "true"
                                              ? const Color(0XFFDADFFE)
                                              : Colors.black.withOpacity(0.09),
                                      onTapFavorito: () {
                                        addORDeleteFavourite(
                                            eventos[itemIndex].idEvento,
                                            eventos[itemIndex].favorito!);
                                      },
                                    ),
                                    options: CarouselOptions(
                                      autoPlay: true,
                                      height: 200,
                                      onPageChanged: (index, reason) {
                                        setState(
                                          () {
                                            _currentIndex = index;
                                          },
                                        );
                                      },
                                    ),
                                  )
                                : CarouselSlider.builder(
                                    itemCount: 1,
                                    itemBuilder: (BuildContext context,
                                            int itemIndex, int pageViewIndex) =>
                                        Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 6.0, vertical: 10.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12
                                                .withOpacity(0.08),
                                            blurRadius: 12,
                                            offset: const Offset(4, 4),
                                          ),
                                        ],
                                      ),
                                      child: const Center(
                                        child: Text("No hay resultados"),
                                      ),
                                    ),
                                    options: CarouselOptions(
                                      autoPlay: true,
                                      height: 200,
                                      onPageChanged: (index, reason) {
                                        setState(
                                          () {
                                            _currentIndex = index;
                                          },
                                        );
                                      },
                                    ),
                                  ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: eventos.asMap().entries.map((entry) {
                            return GestureDetector(
                              onTap: () => _controller.animateToPage(entry.key),
                              child: Container(
                                width: _currentIndex == entry.key ? 24 : 8.0,
                                height: 6.0,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                  color: _currentIndex == entry.key
                                      ? Color(0XFF4760FF)
                                      : Color(0XFF000000).withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
            ),
            Positioned(
              top: 410,
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "No te pierdas este Sábado en White Power",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      Text(
                        "Aquiere tus entradas",
                        style: GoogleFonts.openSans(color: Colors.black38),
                      ),
                      ItemOptionZona(
                        color: Color(0XFF1A1A1A),
                        zona: "Zona VIP",
                        aforo: "200",
                        onPressed: () {
                          Navegacion.ir_ZonaVip(context);
                        },
                      ),
                      ItemOptionZona(
                        color: Color(0XFF4F535B),
                        zona: "Zona BOX",
                        aforo: "200",
                        onPressed: () {
                          Navegacion.ir_ZonaBox(context);
                        },
                      ),
                      ItemOptionZona(
                        color: Color(0XFF4760FF),
                        zona: "Zona General",
                        aforo: "80",
                        onPressed: () {
                          Navegacion.ir_ZonaGeneral(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBarWidget(),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bienvenidos",
                        style: GoogleFonts.openSans(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0XFFFFFFFF),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SearchText(
                        hintText: "Busca tu evento favorito",
                        active: false,
                        icons: Icons.search,
                        controller: buscarEventoController,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
