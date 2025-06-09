import 'dart:convert';

import 'package:chat_sockets/global/environment.dart';
import 'package:chat_sockets/models/login_response.dart';
import 'package:chat_sockets/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier {
  Usuario? usuario;
  bool _autenticando = false;

  bool get autenticando => _autenticando;

  set autenticando(bool valor) {
    _autenticando = valor;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    autenticando = true;

    final data = {'email': email, 'password': password};

    final resp = await http.post(
      Uri.parse('${Environment.apiUrl}/login'),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    if (resp.statusCode == 200) {
      final loginRespnse = LoginResponse.fromJson(jsonDecode(resp.body));
      usuario = loginRespnse.usuario;
    }

    autenticando = false;
  }
}
