import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonCardSelection extends StatelessWidget {
  bool isIconData;
  IconData? iconData;
  bool isAmount;
  String? total;
  String texto;
  Function onTap;
  Color background;

  ButtonCardSelection({
    required this.isIconData,
    required this.isAmount,
    required this.texto,
    this.total,
    this.iconData,
    required this.onTap,
    required this.background,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: Key("ChangeKeyword"),
      onTap: () {
        onTap();
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: background,
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
                            color: Colors.white,
                          )
                        : Container(),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          texto,
                          style: GoogleFonts.openSans(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    isAmount
                        ? Text(
                            total!,
                            style: GoogleFonts.openSans(
                                fontSize: 16, color: Colors.white),
                          )
                        : Text(""),
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
