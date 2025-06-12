class MensajesResponse {
  final bool ok;
  final List<Mensaje> mensajes;

  MensajesResponse({required this.ok, required this.mensajes});

  factory MensajesResponse.fromJson(Map<String, dynamic> json) =>
      MensajesResponse(ok: json["ok"], mensajes: List<Mensaje>.from(json["mensajes"].map((x) => Mensaje.fromJson(x))));
}

class Mensaje {
  final String de;
  final String para;
  final String mensaje;
  final DateTime createdAt;
  final DateTime updatedAt;

  Mensaje({required this.de, required this.para, required this.mensaje, required this.createdAt, required this.updatedAt});

  factory Mensaje.fromJson(Map<String, dynamic> json) => Mensaje(
    de: json["de"],
    para: json["para"],
    mensaje: json["mensaje"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );
}
