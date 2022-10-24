import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonCardSelectionOption extends StatelessWidget {
  bool isIconData;
  IconData? iconData;
  bool isIconDataRight;
  String texto;
  Function onTap;
  Color background;

  ButtonCardSelectionOption({
    required this.isIconData,
    required this.isIconDataRight,
    required this.texto,
    this.iconData,
    required this.onTap,
    required this.background,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(58),
          border: Border.all(color: Colors.black)
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    isIconData
                        ? Icon(
                            iconData,
                            color: Colors.black.withOpacity(0.2),
                          )
                        : Container(width: 25,),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        texto,
                        style: GoogleFonts.openSans(
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ),
                    isIconDataRight ? Icon(
                      Icons.check_circle,
                      color: Colors.black,
                    ) : Container()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
