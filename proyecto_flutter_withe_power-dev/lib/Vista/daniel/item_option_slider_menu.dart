import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemOptionSliderMenu extends StatelessWidget {
  String titulo;
  IconData icon;
  IconData iconStart;
  Function onTap;

   ItemOptionSliderMenu({
   required this.titulo,
   required this.icon,
   required this.onTap,
   required this.iconStart,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
          onTap();
        },
        child: Container(
          width: 135,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(58),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(iconStart),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        titulo,
                        style: GoogleFonts.openSans(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print("hola");
                      },
                      child: Icon(
                        icon,
                        size: 16,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}