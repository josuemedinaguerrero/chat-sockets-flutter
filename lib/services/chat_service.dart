import 'dart:convert';

import 'package:chat_sockets/global/environment.dart';
import 'package:chat_sockets/models/mensajes_response.dart';
import 'package:chat_sockets/models/usuario.dart';
import 'package:chat_sockets/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatService with ChangeNotifier {
  Usuario? usuarioPara;

  Future<List<Mensaje>> getChat(String usuarioID) async {
    final token = await AuthService.getToken();
    if (token == null) return [];

    final resp = await http.get(
      Uri.parse('${Environment.apiUrl}/mensajes/$usuarioID'),
      headers: {'Content-Type': 'application/json', 'x-token': token},
    );

    final mensajesResp = MensajesResponse.fromJson(jsonDecode(resp.body));
    return mensajesResp.mensajes;
  }
}
