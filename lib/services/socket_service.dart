import 'package:chat_sockets/global/environment.dart';
import 'package:chat_sockets/services/auth_service.dart';
import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as io;

enum ServerStatus { online, offline, error, connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;
  late io.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;
  io.Socket get socket => _socket;

  void connect() async {
    final token = await AuthService.getToken();

    _socket = io.io(
      Environment.socketUrl,
      io.OptionBuilder().setTransports(['websocket']).enableForceNew().enableAutoConnect().setExtraHeaders({
        'x-token': token,
      }).build(),
    );

    _socket.onConnect((_) {
      _serverStatus = ServerStatus.online;
      notifyListeners();
    });

    _socket.onDisconnect((_) {
      _serverStatus = ServerStatus.offline;
      notifyListeners();
    });

    _socket.onError((err) {
      _serverStatus = ServerStatus.error;
      notifyListeners();
    });
  }

  void disconnect() {
    _socket.disconnect();
  }
}
