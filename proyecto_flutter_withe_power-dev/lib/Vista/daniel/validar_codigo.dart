import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class validar_codigo extends StatefulWidget {
  String codigo;
  TextEditingController controller;

   validar_codigo({
    required this.codigo,
     required this.controller
  }) ;

  @override
  State<validar_codigo> createState() => _validar_codigoState();
}

class _validar_codigoState extends State<validar_codigo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 56,
      decoration: BoxDecoration(
          color: Colors.black12,
          //   color: Color(0XFFF5F5F5),
          borderRadius: BorderRadius.circular(14)
      ),
      child: Center(child: TextFormField(
        textAlign: TextAlign.center,
        maxLength: 1,
        controller: widget.controller,
        onChanged: (value){
          if(value.length == 1){
            FocusScope.of(context).nextFocus();
          }
        },
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: InputDecoration(
          counterText: "",
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
      )),
    );
  }
}
