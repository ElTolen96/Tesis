import 'package:flutter/material.dart';

class ButtonAddRemoveWidget extends StatelessWidget {
  IconData icon;
  Function onPressed;

  ButtonAddRemoveWidget({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        onPressed();
      },
      padding: EdgeInsets.zero,
      minWidth: 0,
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
        ),
        child: Icon(
          icon,
          color: Colors.black.withOpacity(0.6),
        ),
      ),
    );
  }
}