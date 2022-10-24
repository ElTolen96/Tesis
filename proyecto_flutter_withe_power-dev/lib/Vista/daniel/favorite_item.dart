import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoriteItem extends StatelessWidget {
  String titulo;
  String descripcion;
  String aforo;
  String UrlImagen;
  String fecha;
  String hora;
  Color favorito;
  Color backgroundfavorito;
  Function? onTapFavorito;

  FavoriteItem({Key? key,
    required this.titulo,
    required this.descripcion,
    required this.aforo,
    required this.UrlImagen,
    required this.fecha,
    required this.hora,
    required this.favorito,
    required this.backgroundfavorito,
    this.onTapFavorito,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: 6.0, vertical: 10.0),
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
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(5.0),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          UrlImagen),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Evento Party",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.openSans(
                            fontSize: 12.0,
                            color: Color(0XFF4760FF),
                          ),
                        ),
                        Text(
                          titulo,
                          style: GoogleFonts.openSans(  color: Color(0xff000000),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          descripcion,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.openSans(
                            color: Color(0xffBCBABE),
                            fontSize: 13.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 25,
                  height: 25,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: backgroundfavorito,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child:IconButton(
                    onPressed: () {  onTapFavorito!(); },
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.favorite, size: 15,color: favorito,),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Column(
                    children: [
                      Text(
                        aforo,
                        style: GoogleFonts.openSans(
                            color: Color(0XFF000000),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Aforo",
                        style: GoogleFonts.openSans(
                            color: Color(0XFFBCBABE)),
                      ),
                    ],
                  ),
                ),
                RotatedBox(
                  quarterTurns: 1,
                  child: Container(
                    width: 37,
                    height: 2,
                    decoration: BoxDecoration(
                      color: Color(0xffBCBABE).withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Text(
                        fecha,
                        style: GoogleFonts.openSans(
                            color: Color(0XFF000000),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Fecha",
                        style: GoogleFonts.openSans(
                            color: Color(0XFFBCBABE)),
                      ),
                    ],
                  ),
                ),
                RotatedBox(
                  quarterTurns: 1,
                  child: Container(
                    width: 37,
                    height: 2,
                    decoration: BoxDecoration(
                      color: Color(0xffBCBABE).withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Text(
                       hora,
                        style: GoogleFonts.openSans(
                            color: Color(0XFF000000),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Hora",
                        style: GoogleFonts.openSans(
                            color: Color(0XFFBCBABE)),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}