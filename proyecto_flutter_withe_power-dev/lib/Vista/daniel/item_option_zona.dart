import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemOptionZona extends StatelessWidget {
  String zona;
  String aforo;
  Color color;
  Function onPressed;

  ItemOptionZona({
    required this.zona,
    required this.aforo,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Container(
        height: 119,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  padding: EdgeInsets.only(bottom: 2),
                  onPressed: () {},
                  icon: Icon(Icons.punch_clock_outlined, color: Colors.white, ),),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          zona,
                          maxLines: 2,
                          overflow:
                          TextOverflow.ellipsis,
                          style: GoogleFonts.openSans(
                            fontSize: 14.0,
                            color: Color(0XFFFFFFFF),
                          ),
                        ),
                        Text(
                          "Aforo: $aforo Personas",
                          style: GoogleFonts.openSans(
                            color: Color(0XFFFFFFFF),
                            fontSize: 10.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 36,
                    height: 36,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(0XFFFFFFFF),
                        shape: BoxShape.circle),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.arrow_forward,
                        size: 20,
                        color: Color(0XFF000000),
                      ),
                      onPressed: () {
                        onPressed();
                      },
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