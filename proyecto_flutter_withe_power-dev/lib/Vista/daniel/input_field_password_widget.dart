
import 'package:flutter/material.dart';

class InputFieldPasswordWidget extends StatefulWidget {
  String texto;
  TextEditingController? controller;
  Function? onTap;

  InputFieldPasswordWidget({this.controller, this.onTap, required this.texto});

  @override
  _InputFieldPasswordWidgetState createState() => _InputFieldPasswordWidgetState();
}

class _InputFieldPasswordWidgetState extends State<InputFieldPasswordWidget> {
  bool isInvisible = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.onTap!();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20.0),
        child: TextFormField(
          controller: widget.controller,
          obscureText: isInvisible,
          decoration: InputDecoration(
            hintText: widget.texto,
            hintStyle: TextStyle(
              fontSize: 14.0,
            ),
            prefixIcon: Icon(Icons.lock,  color: Colors.black),
            suffixIcon: IconButton(
              onPressed: (){
                isInvisible = !isInvisible;
                setState(() {

                });
              },
              icon: Icon(Icons.remove_red_eye),
            ),
            fillColor: Color(0XFFF0F0F0),
            filled: true,
            counterText: "",
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.0),
              borderSide: BorderSide.none,
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.0),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.0),
              borderSide: BorderSide.none,
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.0),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.0),
              borderSide: BorderSide.none,
            ),
          ),
          validator: (String? value) {
            if (value!.isEmpty) {
              return "El campo no puede estar vacío";
            }
            return null;
          },
        ),
      ),
    );
  }
}
