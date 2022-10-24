import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchText extends StatefulWidget {
  String hintText;
  int? maxLines;
  TextInputType? textInputType;
  int? maxLength;
  TextEditingController? controller;
  bool? validator;
  bool? active;
  IconData? icons;

  SearchText({required this.hintText,
    this.maxLines,
    this.textInputType,
    this.maxLength,
    this.controller,
    this.validator,
    this.icons,
    required this.active,});

  @override
  _SearchTextState createState() => _SearchTextState();
}

class _SearchTextState extends State<SearchText> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: widget.controller,
              keyboardType: widget.textInputType,
              maxLines: widget.maxLines,
              maxLength: widget.maxLength,
              readOnly: widget.active!,
              inputFormatters: widget.hintText == "Nombre" ||
                  widget.hintText == "Apellido Paterno" ||
                  widget.hintText == "Apellido Materno"
                  ? [FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]'))]
                  : [],
              style: TextStyle(
                color: Colors.white
              ),
              decoration: InputDecoration(
                counterText: "",
                prefixIcon:  Icon(widget.icons, color: Colors.white,),
                hintText: widget.hintText,
                hintStyle: GoogleFonts.openSans(
                    fontSize: 14.0,
                    color: Colors.white
                ),
                filled: true,
                fillColor: const Color(0XFF4F535B),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0),
                  borderSide: BorderSide.none,
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0),
                  borderSide: BorderSide.none,
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (String? value) {
                if (widget.validator != null) return null;

                if (value!.isEmpty) {
                  return "El campo no puede estar vacío";
                }

                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
