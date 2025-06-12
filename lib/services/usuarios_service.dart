import 'dart:convert';

import 'package:chat_sockets/global/environment.dart';
import 'package:chat_sockets/models/usuario.dart';
import 'package:chat_sockets/models/usuarios_response.dart';
import 'package:chat_sockets/services/auth_service.dart';
import 'package:http/http.dart' as http;

class UsuariosService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      final token = await AuthService.getToken();
      if (token == null) return [];

      final resp = await http.get(
        Uri.parse('${Environment.apiUrl}/usuarios'),
        headers: {'Content-Type': 'application/json', 'x-token': token},
      );

      if (resp.statusCode == 200) return UsuariosResponse.fromJson(jsonDecode(resp.body)).usuarios;

      return [];
    } catch (e) {
      return [];
    }
  }
}
