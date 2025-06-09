class Usuario {
  final bool online;
  final String email;
  final String nombre;
  final String uid;

  Usuario({required this.online, required this.email, required this.nombre, required this.uid});

  factory Usuario.fromJson(Map<String, dynamic> json) =>
      Usuario(nombre: json["nombre"], email: json["email"], online: json["online"], uid: json["uid"]);
}
