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

import '../../Controlador/servicios/api_services.dart';

class HomePageSinFavoritos extends StatefulWidget {
  @override
  _HomePageSinFavoritosState createState() => _HomePageSinFavoritosState();
}

class _HomePageSinFavoritosState extends State<HomePageSinFavoritos> {
  late final TabController tabController;
  final APIServices _apiServices = APIServices();
  bool isLoading = false;

  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  List<EventoModel> eventos = [];

  getListarUsuario() async{


  }
  getData() async {
    isLoading = true;
    _apiServices.getEventos().then((value) {
      eventos = value;
      isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final CarouselController _controller = CarouselController();

    return Scaffold(
        drawer: SideMenu(),
        body: Stack(
          children: [
            Container(
              height: 240,
              decoration: BoxDecoration(
                color: Color(0XFF1A1A1A),
              ),
            ),
            Positioned(
              top: 240,
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
