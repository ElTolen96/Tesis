import 'package:flutter/material.dart';

class DialogDatosWidget extends StatelessWidget {
  Function onDelete;

  DialogDatosWidget({required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      title: Center(
        child: const Text(
          "Datos de Contacto",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      content: Container(
        height: 170,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Desarrollador 1:",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black87,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 10,),
            Text(
              "Nombre: Jean Paul Carrasco Correa",
              maxLines: 2,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black87,
              ),
            ),
            Text(
              "Email: jeancarrasco2703999@outlook.es",
              maxLines: 2,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black87,
              ),
            ),
            Text(
              "Github: Paul2703",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20,),
            Text(
              "Desarrollador 2:",
              style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 10,),
            Text(
              "Nombre: César Manuel Tolentino Véliz",
              maxLines: 2,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black87,
              ),
            ),
            Text(
              "Email: ctolentinov96@gmail.com",
              maxLines: 2,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black87,
              ),
            ),
            Text(
              "Github: ElTolen96",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text(
            "Cerrar",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          onPressed: () {
            onDelete();
            // isLoading = true;
            // setState(() {});
            // deleteItem();
            // Navigator.pop(context);
          },
        ),
      ],
    );
  }
}