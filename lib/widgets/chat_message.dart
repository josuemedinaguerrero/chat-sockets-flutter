import 'package:chat_sockets/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatMessage extends StatelessWidget {
  final String texto;
  final String uid;
  final AnimationController animationController;

  const ChatMessage({super.key, required this.texto, required this.uid, required this.animationController});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        child: uid == authService.usuario!.uid ? _MyMessage(texto: texto) : _NoMyMessage(texto: texto),
      ),
    );
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
