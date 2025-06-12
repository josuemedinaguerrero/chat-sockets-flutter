import 'package:chat_sockets/models/usuario.dart';

class UsuariosResponse {
  final bool ok;
  final List<Usuario> usuarios;

  UsuariosResponse({required this.ok, required this.usuarios});

  factory UsuariosResponse.fromJson(Map<String, dynamic> json) =>
      UsuariosResponse(ok: json["ok"], usuarios: List<Usuario>.from(json["usuarios"].map((x) => Usuario.fromJson(x))));
}
