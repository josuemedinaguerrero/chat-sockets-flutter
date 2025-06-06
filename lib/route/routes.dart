import 'package:chat_sockets/pages/chat_page.dart';
import 'package:chat_sockets/pages/loading_page.dart';
import 'package:chat_sockets/pages/login_page.dart';
import 'package:chat_sockets/pages/register_page.dart';
import 'package:chat_sockets/pages/usuarios_page.dart';
import 'package:flutter/widgets.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'usuarios': (_) => UsuariosPage(),
  'chat': (_) => ChatPage(),
  'login': (_) => LoginPage(),
  'register': (_) => RegisterPage(),
  'loading': (_) => LoadingPage(),
};
