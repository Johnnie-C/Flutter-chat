library chatting;

import 'dart:io';
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:chatting/chat_types.dart' as types;
import 'package:chatting/chat_ui.dart';
import 'package:chatting/chat_view.dart';
import 'package:common/utils/color_utils.dart';
import 'package:common/style_guide/spacing.dart';
import 'package:common/utils/text_theme_utils.dart';
import 'package:common/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttery/resources/app_images.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;


class ChatDemoPage extends StatefulWidget {
  const ChatDemoPage({super.key});

  @override
  State<ChatDemoPage> createState() => _ChatDemoPageState();
}

class _ChatDemoPageState extends State<ChatDemoPage> {

  late WebSocketChannel _channel;
  final TextEditingController _inputController = TextEditingController();

  List<types.Message> _messages = [];
  final _currentUser = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );

  final _contact = const types.User(
    id: '4c2307ba-3d40-442f-b1ff-b271f63904ca',
    firstName: 'John',
    lastName: 'Doe',
    imageUrl: 'https://i.pravatar.cc/300?u=e52552f4-835d-4dbe-ba77-b076e659774d',
  );

  @override
  void initState() {
    super.initState();
    _loadMessages();
    _connectToWebSocket();
  }

  @override
  void deactivate() {
    super.deactivate();
    _channel.sink.close(status.normalClosure);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const CustomAppBar(title: "Chat"),
    body: ChatView(
      messages: _messages,
      currentUser: _currentUser,
      onSendMessage: _onSendMessage,
      theme: _theme(),
      bubbleBuilder: _bubbleBuilder,
      nameBuilder: _nameBuilder,
      inputOptions: _inputOptions,
    ),
  );

  void _loadMessages() async {
    final response = await rootBundle.loadString('assets/mock_data/mock_messages.json');
    final messages = (jsonDecode(response) as List)
        .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
        .toList();

    setState(() {
      _messages = messages;
    });
  }

  void _connectToWebSocket() async {
    final wsUrl = Uri.parse('wss://echo.websocket.org');
    _channel = WebSocketChannel.connect(wsUrl);

    try {
      await _channel.ready;
    } on SocketException catch (e) {
      print('connection error: $e');
    } on WebSocketChannelException catch (e) {
      print('connection error: $e');
    }

    _channel.stream.listen((message) {
      print('did receive message: $message');
      _onReceive('echo message: $message');
    });

    _channel.sink.done.then((message) {
      print("done message: $message");
      print("disconnected");
      print("closed code: ${_channel.closeCode}, closed reason: ${_channel.closeReason}");
    }).catchError((error) {
      print("done error: $error");
      print('Error closing WebSocket: $error');
    });
  }

  void _onReceive(String text) {
    final message = types.TextMessage(
      author: _contact,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: text,
    );

    setState(() {
      _messages.insert(0, message);
    });
  }

  void _onPressSendButton(String text) {
    if (text.isEmpty) return;

    _inputController.text = "";

    final message = types.TextMessage(
      author: _currentUser,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: text,
    );

    _onSendMessage(message);
  }

  void _onSendMessage(types.Message message) {
    setState(() {
      _sendMessageToServer(message);
      _messages.insert(0, message);
    });
  }

  void _sendMessageToServer(types.Message message) {
    if (message is types.TextMessage) {
      _channel.sink.add(message.text);
    }
  }

  ChatTheme _theme() {
    return DefaultChatTheme(
      backgroundColor: context.colorScheme.surface,
      documentIcon: Image.asset(AppImages.messageFileImage),

      // received message
      receivedMessageBodyTextStyle: context.textTheme.bodyMedium!.copyWith(
        color: Colors.white,
      ),
      receivedMessageCaptionTextStyle: context.textTheme.bodySmall!.copyWith(
        color: context.colorScheme.surface,
      ),
      receivedMessageLinkTitleTextStyle: context.textTheme.labelLarge!.copyWith(
        color: Colors.white70,
      ),
      receivedMessageLinkDescriptionTextStyle: context.textTheme.bodySmall!.copyWith(
        color: Colors.white54,
      ),
      receivedMessageDocumentIconColor: context.colorScheme.onPrimary,

      // sent message
      sentMessageBodyTextStyle: context.textTheme.bodyMedium!.copyWith(
        color: context.colorScheme.onPrimary,
      ),
      sentMessageCaptionTextStyle: context.textTheme.bodySmall!.copyWith(
        color: context.colorScheme.surface,
      ),
      sentMessageLinkTitleTextStyle: context.textTheme.labelLarge!.copyWith(
        color: Colors.white70,
      ),
      sentMessageLinkDescriptionTextStyle: context.textTheme.bodySmall!.copyWith(
        color: Colors.white54,
      ),
      sentMessageDocumentIconColor: context.colorScheme.onPrimary,

      // input section
      inputBorderRadius: BorderRadius.zero,
      inputBackgroundColor: context.colorScheme.surfaceContainer,
      attachmentButtonIcon: Image.asset(AppImages.chatAttachmentImage),
      inputTextStyle: context.textTheme.labelLarge!.copyWith(
        color: context.colorScheme.onSurface,
      ),
      inputTextDecoration:InputDecoration(
        contentPadding: const EdgeInsets.only (left: 12, right: 12,),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(28)),
          borderSide: BorderSide(
            width: 1,
            color: context.colorScheme.primary,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(28)),
          borderSide: BorderSide(
            width: 1,
            color: context.colorScheme.primary,
          ),
        ),
        suffixIcon: InkWell(
          splashFactory: NoSplash.splashFactory,
          child: Padding(
            padding: Inset.smallVertical,
            child: Image.asset(
              AppImages.sendMessageImage,
              height: 24,
              width: 24,
            ),
          ),
          onTap: () => {_onPressSendButton(_inputController.text) },
        ),
      ),
    );
  }

  BorderRadius borderRadius = const BorderRadius.all(Radius.circular(10));

  Widget _bubbleBuilder(
      Widget child, {
        required types.Message message,
        required bool nextMessageInGroup,
      }) =>
      Padding(
        padding: Inset.xSmallVertical,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: message.author.id == "82091008-a484-4a89-ae75-a22bf8d6f3ac"
                ? context.colorScheme.primary
                : context.colorScheme.surfaceContainer,
          ),
          child: ClipRRect(
            borderRadius: borderRadius,
            child: child,
          ),
        ),
      );

  Widget _nameBuilder(types.User user) => const SizedBox.shrink();

  InputOptions get _inputOptions => InputOptions(
    sendButtonVisibilityMode: SendButtonVisibilityMode.hidden,
    textEditingController: _inputController,
  );

}
