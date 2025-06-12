import 'package:chat_sockets/models/usuario.dart';
import 'package:chat_sockets/services/auth_service.dart';
import 'package:chat_sockets/services/chat_service.dart';
import 'package:chat_sockets/services/socket_service.dart';
import 'package:chat_sockets/services/usuarios_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({super.key});

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final usuariosService = UsuariosService();
  List<Usuario> usuarios = [];

  Future<void> _cargarUsuarios() async {
    usuarios = await usuariosService.getUsuarios();
    setState(() {});
  }

  Future<void> onRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    _cargarUsuarios();
  }

  @override
  void initState() {
    _cargarUsuarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(authService.usuario!.nombre, style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            socketService.disconnect();
            Navigator.pushReplacementNamed(context, 'login');
            AuthService.deleteToken();
          },
          icon: Icon(Icons.exit_to_app, color: Colors.black87),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child:
                socketService.serverStatus == ServerStatus.online
                    ? Icon(Icons.check_circle, color: Colors.blue[400])
                    : Icon(Icons.online_prediction_outlined, color: Colors.red),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => _UserTile(usuario: usuarios[index]),
          separatorBuilder: (context, index) => Divider(),
          itemCount: usuarios.length,
        ),
      ),
    );
  }
}

class _UserTile extends StatelessWidget {
  final Usuario usuario;

  const _UserTile({required this.usuario});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(child: Text(usuario.nombre.substring(0, 2))),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: usuario.online ? Colors.green[300] : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.usuarioPara = usuario;
        Navigator.pushNamed(context, 'chat');
      },
    );
  }
}
