import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DatosEvento extends StatelessWidget {
  IconData iconData;
  String titutlo1;
  String titutlo2;

   DatosEvento({required this.iconData, required this.titutlo1, required this.titutlo2});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                  width: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Color(0xffDADFFE)),
                  child: Icon(
                    iconData,
                    color: Color(0xff4760FF),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          titutlo1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.openSans(
                            color: Color(0xffBCBABE),
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          titutlo2,
                          style: GoogleFonts.openSans(
                              color: Color(0xff000000),
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
