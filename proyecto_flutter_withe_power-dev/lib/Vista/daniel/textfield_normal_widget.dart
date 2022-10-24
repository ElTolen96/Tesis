import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldNormalWidget extends StatelessWidget {
  String hintText;
  int? maxLines;
  TextInputType? textInputType;
  int? maxLength;
  TextEditingController? controller;
  bool? validator;
  bool? active;
  IconData? icons;

  TextFieldNormalWidget({
    required this.hintText,
    this.maxLines,
    this.textInputType,
    this.maxLength,
    this.controller,
    this.validator,
    this.icons,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        width: hintText == "Dia" || hintText == "Mes" || hintText == "Año"? width * 0.25 :  double.infinity ,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controller,
              keyboardType: textInputType,
              maxLines: maxLines,
              maxLength: maxLength,
              readOnly: active!,
              inputFormatters: hintText == "Nombre" ||
                  hintText == "Apellido Paterno" ||
                  hintText == "Apellido Materno"
                  ? [FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]'))]
                  : [],
              decoration: InputDecoration(
                counterText: "",
                hintText: hintText,
                hintStyle: const TextStyle(
                  fontSize: 14.0,
                ),
                filled: true,
                fillColor: Color(0XFFF0F0F0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (String? value) {
                if (validator != null) return null;

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

bool validateEmail(String value) {
  RegExp regex = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  return (!regex.hasMatch(value)) ? false : true;
}
