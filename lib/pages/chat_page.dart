import 'package:chat_sockets/services/auth_service.dart';
import 'package:chat_sockets/services/chat_service.dart';
import 'package:chat_sockets/services/socket_service.dart';
import 'package:chat_sockets/widgets/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final List<ChatMessage> _messages = [];
  late SocketService socketService;

  @override
  void initState() {
    super.initState();

    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.on('mensaje-personal', (data) {
      ChatMessage newMessage = ChatMessage(
        texto: data['mensaje'],
        uid: data['de'],
        animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 400)),
      );

      setState(() {
        _messages.insert(0, newMessage);
      });

      newMessage.animationController.forward();
    });
  }

  @override
  void dispose() {
    for (var message in _messages) {
      message.animationController.dispose();
    }

    socketService.socket.off('mensaje-personal');

    super.dispose();
  }

  void insertMessage(ChatMessage message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatService = Provider.of<ChatService>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
              child: Text(chatService.usuarioPara!.nombre.substring(0, 2), style: TextStyle(fontSize: 12)),
            ),
            SizedBox(height: 3),
            Text(chatService.usuarioPara!.nombre, style: TextStyle(color: Colors.black87, fontSize: 12)),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                reverse: true,
                physics: BouncingScrollPhysics(),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _messages[index];
                },
              ),
            ),
            Divider(),
            Container(color: Colors.white, child: _InputChat(insertMessage: insertMessage)),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}

class _InputChat extends StatefulWidget {
  final void Function(ChatMessage message) insertMessage;

  const _InputChat({required this.insertMessage});

  @override
  State<_InputChat> createState() => _InputChatState();
}

class _InputChatState extends State<_InputChat> with TickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  bool disabledButton = true;

  void _handleSubmit(String texto) {
    if (texto.isEmpty) return;

    final chatService = Provider.of<ChatService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);

    _textController.clear();

    final newMessage = ChatMessage(
      texto: texto,
      uid: '123',
      animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 400)),
    );

    widget.insertMessage(newMessage);
    newMessage.animationController.forward();

    socketService.socket.emit('mensaje-personal', {
      'de': authService.usuario?.uid,
      'para': chatService.usuarioPara?.uid,
      'mensaje': texto,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmit,
              onChanged: (value) {
                setState(() {
                  disabledButton = value.isEmpty ? true : false;
                });
              },
              decoration: InputDecoration.collapsed(hintText: 'Enviar mensaje'),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            child: AnimatedOpacity(
              opacity: disabledButton ? 0.5 : 1.0,
              duration: Duration(milliseconds: 300),
              child: Transform.scale(
                scale: disabledButton ? 0.95 : 1.0,
                child: IconButton(
                  onPressed: disabledButton ? null : () => _handleSubmit(_textController.text.trim()),
                  icon: Icon(Icons.send),
                  color: Colors.blue[400],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
