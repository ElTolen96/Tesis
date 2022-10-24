import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class TextFieldPasswordNormalIconWidget extends StatefulWidget {
  String hintText;
  TextInputType? textInputType;
  int? maxLength;
  TextEditingController? controller;
  bool? validator;
  bool? active;
  bool? invisible;
  IconData? icons;

  TextFieldPasswordNormalIconWidget({
    required this.hintText,
    this.textInputType,
    this.maxLength,
    this.controller,
    this.validator,
    this.icons,
    this.invisible,
    required this.active,
  });

  @override
  State<TextFieldPasswordNormalIconWidget> createState() => _TextFieldPasswordNormalIconWidgetState();
}

class _TextFieldPasswordNormalIconWidgetState extends State<TextFieldPasswordNormalIconWidget> {
  bool isInvisible = true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Container(
        width: widget.hintText == "Dia" || widget.hintText == "Mes" || widget.hintText == "Año"? width * 0.25 :  double.infinity ,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: widget.controller,
              keyboardType: widget.textInputType,
              maxLength: widget.maxLength,
              readOnly: widget.active!,
              obscureText: isInvisible,
              inputFormatters: widget.hintText == "Nombre" ||
                  widget.hintText == "Apellido Paterno" ||
                  widget.hintText == "Apellido Materno"
                  ? [FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]'))]
                  : [],
              decoration: InputDecoration(
                counterText: "",
                prefixIcon:  Icon(widget.icons, color: Colors.black,),
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                  fontSize: 14.0,
                ),
                suffixIcon: IconButton(
                  onPressed: (){
                    isInvisible = !isInvisible;
                    setState(() {

                    });
                  },
                  icon: Icon(Icons.remove_red_eye, color: Colors.black,),
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

bool validateEmail(String value) {
  RegExp regex = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  return (!regex.hasMatch(value)) ? false : true;
}
