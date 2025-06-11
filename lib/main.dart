import 'package:chat_sockets/route/routes.dart';
import 'package:chat_sockets/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => AuthService())],
      child: MaterialApp(title: 'Material App', debugShowCheckedModeBanner: false, initialRoute: 'loading', routes: appRoutes),
    );
  }
}
