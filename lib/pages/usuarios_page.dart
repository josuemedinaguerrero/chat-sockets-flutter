import 'package:chat_sockets/models/usuario.dart';
import 'package:flutter/material.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({super.key});

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final List<Usuario> usuarios = [
    Usuario(online: false, email: 'test1@google.com', nombre: 'Maria', uid: '1'),
    Usuario(online: true, email: 'test2@google.com', nombre: 'Eduard', uid: '2'),
    Usuario(online: true, email: 'test3@google.com', nombre: 'Nel', uid: '3'),
    Usuario(online: true, email: 'test4@google.com', nombre: 'Alta', uid: '4'),
  ];

  Future<void> onRefresh() async {
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Nombre', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.exit_to_app, color: Colors.black87)),
        actions: [Container(margin: EdgeInsets.only(right: 10), child: Icon(Icons.check_circle, color: Colors.blue[400]))],
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
    );
  }
}
