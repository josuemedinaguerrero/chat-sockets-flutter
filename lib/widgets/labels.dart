import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String ruta;
  final String message;
  final String textButton;

  const Labels({super.key, required this.ruta, required this.message, required this.textButton});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(message, style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300)),
        SizedBox(height: 10),
        TextButton(
          onPressed: () => Navigator.pushReplacementNamed(context, ruta),
          child: Text(textButton, style: TextStyle(color: Colors.blue[600], fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
