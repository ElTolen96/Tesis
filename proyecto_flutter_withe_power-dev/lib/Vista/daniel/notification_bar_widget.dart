import 'package:flutter/material.dart';
import 'package:proyecto_withe_power/Controlador/navegacion.dart';

class NotificationBarWidget extends StatefulWidget {
  const NotificationBarWidget({Key? key}) : super(key: key);

  @override
  _NotificationBarWidgetState createState() => _NotificationBarWidgetState();
}

class _NotificationBarWidgetState extends State<NotificationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navegacion.ir_NotificarUsuario(context);
      },
      child: Container(
        child: Stack(
          children: [
            Icon(
              Icons.notifications,
              color: Colors.white,
              size: 30,
            ),
            Container(
              width: 30,
              height: 30,
              alignment: Alignment.topRight,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff4760FF),
                    border: Border.all(color: Colors.white, width: 1)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
