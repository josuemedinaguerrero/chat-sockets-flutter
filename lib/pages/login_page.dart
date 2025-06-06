import 'package:chat_sockets/widgets/custom_input.dart';
import 'package:chat_sockets/widgets/labels.dart';
import 'package:chat_sockets/widgets/logo.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Logo(titulo: 'Messenger'),
                  Form(),
                  Labels(ruta: 'register', message: '¿No tienes cuenta?', textButton: 'Crea una cuenta ahora!'),
                  Text('Términos y condiciones de uso', style: TextStyle(fontWeight: FontWeight.w200)),
                ],
              ),
            ),
          ],
          physics: BouncingScrollPhysics(),
        ),
      ),
    );
  }
}

class Form extends StatefulWidget {
  const Form({super.key});

  @override
  State<Form> createState() => _FormState();
}

class _FormState extends State<Form> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailController,
          ),

          CustomInput(icon: Icons.lock_outline, placeholder: 'Contraseña', textController: passController, isPassword: true),

          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                print('PASSWORD: ${passController.text}');
                print('EMAIL: ${emailController.text}');
              },
              child: Text('HOLA MUNDO'),
            ),
          ),
        ],
      ),
    );
  }
}
