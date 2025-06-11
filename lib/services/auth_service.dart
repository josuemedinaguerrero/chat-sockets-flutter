import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:chat_sockets/global/environment.dart';
import 'package:chat_sockets/models/login_response.dart';
import 'package:chat_sockets/models/usuario.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier {
  Usuario? usuario;
  bool _autenticando = false;
  bool autenticado = false;

  final _storage = FlutterSecureStorage();

  bool get autenticando => _autenticando;

  set autenticando(bool valor) {
    _autenticando = valor;
    notifyListeners();
  }

  // Getters del token de forma estática
  static Future<String?> getToken() async {
    final storage = FlutterSecureStorage();
    return await storage.read(key: 'token-key');
  }

  static Future<void> deleteToken() async {
    final storage = FlutterSecureStorage();
    await storage.delete(key: 'token-key');
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token-key');
    if (token == null) return false;

    final resp = await http.get(
      Uri.parse('${Environment.apiUrl}/login/renew'),
      headers: {'Content-Type': 'application/json', 'x-token': token},
    );

    if (resp.statusCode == 200) {
      final loginRespnse = LoginResponse.fromJson(jsonDecode(resp.body));
      usuario = loginRespnse.usuario;
      await _guardarToken(loginRespnse.token);
      return true;
    }

    _logout();
    return false;
  }

  Future<bool> login(String email, String password) async {
    autenticando = true;

    final data = {'email': email, 'password': password};

    final resp = await http.post(
      Uri.parse('${Environment.apiUrl}/login'),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    autenticando = false;

    if (resp.statusCode == 200) {
      final loginRespnse = LoginResponse.fromJson(jsonDecode(resp.body));
      usuario = loginRespnse.usuario;
      await _guardarToken(loginRespnse.token);
      return true;
    }

    return false;
  }

  Future<bool> register(String nombre, String email, String password) async {
    autenticando = true;

    final data = {'nombre': nombre, 'email': email, 'password': password};

    final resp = await http.post(
      Uri.parse('${Environment.apiUrl}/login/new'),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    autenticando = false;

    if (resp.statusCode == 200) {
      final loginRespnse = LoginResponse.fromJson(jsonDecode(resp.body));
      usuario = loginRespnse.usuario;
      await _guardarToken(loginRespnse.token);
      return true;
    }

    return false;
  }

  Future<void> _guardarToken(String token) async {
    await _storage.write(key: 'token-key', value: token);
  }

  Future<void> _logout() async {
    await _storage.delete(key: 'token-key');
  }
}
