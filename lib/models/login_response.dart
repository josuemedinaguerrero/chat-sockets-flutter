import 'package:chat_sockets/models/usuario.dart';

class LoginResponse {
  final bool ok;
  final Usuario usuario;
  final String token;

  LoginResponse({required this.ok, required this.usuario, required this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      LoginResponse(ok: json["ok"], usuario: Usuario.fromJson(json["usuario"]), token: json["token"]);
}
