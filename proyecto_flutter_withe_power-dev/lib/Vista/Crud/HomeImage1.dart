import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_withe_power/Controlador/navegacion.dart';
import 'package:proyecto_withe_power/Modelo/Mensajes.dart';
import 'package:proyecto_withe_power/Vista/daniel/textfield_normal_Icons_widget.dart';

class HomeImage1 extends StatefulWidget {
  static final String routeName = Mensajes.RUTA_OLVIDARCONTRASENA1USUARIO;

  const HomeImage1({Key? key});

  @override
  _HomeImage1State createState() => _HomeImage1State();
}

class _HomeImage1State extends State<HomeImage1> {
  late List<String> imgList = [
    'https://www.diariodenavarra.es/uploads/2020/06/12/60b02695de2c9.jpeg',
    'https://static.elcorreo.com/www/multimedia/202202/18/media/cortadas/discoteca18-k20C--984x468@El%20Correo.jpg',
    'https://cdn.getyourguide.com/img/tour/5cf4f4d8ca3fa.jpeg/98.jpg',
  ];
  int _currentIndex = 0;
  late List<Widget> imageSliders = imgList
      .map((item) => Container(
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(item, fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            'No. ${imgList.indexOf(item)} image',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    final CarouselController _controller = CarouselController();

    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navegacion.ir_Inicio(context);
                    },
                    child: Text(
                      "Omitir",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navegacion.ir_HOMEIMAGEN2USUARIO(context);
                    },
                    child: Icon(Icons.navigate_next_outlined),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(CircleBorder()),
                      padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                      backgroundColor: MaterialStateProperty.all(
                          Color(0XFF999999)), // <-- Button color
                      overlayColor:
                          MaterialStateProperty.resolveWith<Color?>((states) {
                        if (states.contains(MaterialState.pressed))
                          return Color(0XFF999999); // <-- Splash color
                      }),
                    ),
                  )
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                  CarouselSlider(

                  carouselController: _controller,
                  options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 2.0,
                      height: 250,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      }),
                      items: imgList
                          .map(
                            (item) => Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30.0),
                                ),
                                child: Image.network(
                                  item,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                      )
                          .toList(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: imgList.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => _controller.animateToPage(entry.key),
                          child: Container(
                            width: _currentIndex == entry.key ? 24 : 8.0,
                            height: 6.0,
                            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                color: _currentIndex == entry.key ? Color(0XFF4760FF)  : Color(0XFF000000).withOpacity(0.4),
                                borderRadius: BorderRadius.circular(10),),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 24,),
                    Text(
                      "Reserva tus entradas de manera rápida y desde tu casa.",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.bold, fontSize: 28),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Ahora puedes adquirir tus entradas desde tu celular y ten una mejor experiencia.",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.openSans(
                          color: Colors.black, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
