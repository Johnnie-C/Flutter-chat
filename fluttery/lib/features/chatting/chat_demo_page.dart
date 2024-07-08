library chatting;

import 'dart:io';

import 'package:chatting/chat_view.dart';
import 'package:common/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class ChatDemoPage extends StatefulWidget {
  const ChatDemoPage({super.key});

  @override
  State<ChatDemoPage> createState() => _ChatDemoPageState();
}

class _ChatDemoPageState extends State<ChatDemoPage> {

  late WebSocketChannel channel;

  @override
  void initState() {
    super.initState();
    _connectToWebSocket();
  }

  @override
  void deactivate() {
    super.deactivate();
    channel.sink.close(status.normalClosure);
  }

  void _connectToWebSocket() async {
    final wsUrl = Uri.parse('wss://echo.websocket.org');
    channel = WebSocketChannel.connect(wsUrl);

    channel.sink.done.then((message) {
      print("done message: $message");
      print("disconnected");
      print("closed code: ${channel.closeCode}, closed reason: ${channel.closeReason}");
    }).catchError((error) {
      print("done error: $error");
      print('Error closing WebSocket: $error');
    });

    try {
      await channel.ready;
    } on SocketException catch (e) {
      print('connection error: $e');
    } on WebSocketChannelException catch (e) {
      print('connection error: $e');
    }

    channel.stream.listen((message) {
      print('did receive message: $message');
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const CustomAppBar(title: "Chat"),
    body: ChatView(onSendTextMessage: _onSendTextMessage,),
  );

  void _onSendTextMessage(String message) {
    channel.sink.add(message);
  }

}

