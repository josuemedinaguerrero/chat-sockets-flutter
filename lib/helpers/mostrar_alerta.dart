import 'package:flutter/material.dart';

mostrarAlerta(BuildContext context, String titulo, String subtitulo) {
  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: Text(titulo),
          content: Text(subtitulo),
          actions: [
            MaterialButton(elevation: 5, textColor: Colors.blue, onPressed: () => Navigator.pop(context), child: Text('Ok')),
          ],
        ),
  );
}
