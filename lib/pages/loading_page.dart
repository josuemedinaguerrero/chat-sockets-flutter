import 'package:chat_sockets/services/auth_service.dart';
import 'package:chat_sockets/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();

    _checkLoginState();
  }

  void _checkLoginState() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final isLoggedIn = await authService.isLoggedIn();

    if (!context.mounted) return;

    if (isLoggedIn) {
      // ignore: use_build_context_synchronously
      final socketService = Provider.of<SocketService>(context, listen: false);
      socketService.connect();

      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, 'usuarios');
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, 'login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
