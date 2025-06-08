import 'package:chat_sockets/widgets/chat_message.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<ChatMessage> _messages = [
    ChatMessage(texto: 'Hola Mundo', uid: '123'),
    ChatMessage(texto: 'Hola Mundo', uid: '123'),
    ChatMessage(texto: 'Hola Mund dsf dsfdsf dsfdsf s fidsbfi bdifbdsif iudsb fuibdsui bfuidsb ufi iufbdsuib fiduo', uid: '123'),
    ChatMessage(texto: 'Hola Mundo', uid: '123'),
    ChatMessage(texto: 'Test Mundo', uid: '456'),
    ChatMessage(texto: 'Test Mundo', uid: '456'),
    ChatMessage(texto: 'Test Mundo', uid: '456'),
  ];

  void insertMessage(ChatMessage message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            CircleAvatar(backgroundColor: Colors.blue[100], maxRadius: 14, child: Text('Te', style: TextStyle(fontSize: 12))),
            SizedBox(height: 3),
            Text('Melissa Flores', style: TextStyle(color: Colors.black87, fontSize: 12)),
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

class _InputChatState extends State<_InputChat> {
  final TextEditingController _textController = TextEditingController();
  bool disabledButton = true;

  void _handleSubmit(String texto) {
    _textController.clear();
    final newMessage = ChatMessage(texto: texto, uid: '123');
    widget.insertMessage(newMessage);
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
