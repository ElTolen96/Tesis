import 'package:flutter/material.dart';
import 'package:proyecto_withe_power/Controlador/servicios/constants.dart';

messageSuccessRegisterSnackBar(BuildContext context, String mensaje){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: COLOR_FONT_PRIMARY,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 3),
      content: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10.0,
          ),
          Text(
            mensaje,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

messageWelcomeSnackBar(BuildContext context, String mensaje){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: COLOR_FONT_PRIMARY,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 2),
      content: Row(
        children:  [
          const Icon(
            Icons.home,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10.0,
          ),
          Text(mensaje,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}


messageSuccessUpdateSnackBar(BuildContext context, String mensaje){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Color(0xff0747cb),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: const [
          Icon(
            Icons.edit,
            color: Colors.white,
          ),

          SizedBox(
            width: 10.0,
          ),
          Text(
            "El registro se editó correctamente.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

messageSuccessInfoSnackBar(BuildContext context, String mensaje){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: COLOR_INFO,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 2),
      content: Row(
        children:  [
          const Icon(
            Icons.info,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Text(mensaje,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              //"Debe completar todos los campos",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

messageSuccessDeleteSnackBar(BuildContext context, String mensaje){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: COLOR_CANCEL,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 2),
      content: Row(
        children:  [
          const Icon(
            Icons.delete_forever,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10.0,
          ),
          Text(mensaje,
            //"Debe completar todos los campos",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
