import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String texto;
  final String uid;

  const ChatMessage({super.key, required this.texto, required this.uid});

  @override
  Widget build(BuildContext context) {
    return uid == '123' ? _MyMessage(texto: texto) : _NoMyMessage(texto: texto);
  }
}

class _MyMessage extends StatelessWidget {
  final String texto;

  const _MyMessage({required this.texto});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(bottom: 5, right: 5, left: 50),
        decoration: BoxDecoration(color: Color(0xFF4D9EF6), borderRadius: BorderRadius.circular(20)),
        child: Text(texto, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class _NoMyMessage extends StatelessWidget {
  final String texto;

  const _NoMyMessage({required this.texto});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(bottom: 5, right: 50, left: 5),
        decoration: BoxDecoration(color: Color(0xFFE4E5E8), borderRadius: BorderRadius.circular(20)),
        child: Text(texto, style: TextStyle(color: Colors.black87)),
      ),
    );
  }
}
