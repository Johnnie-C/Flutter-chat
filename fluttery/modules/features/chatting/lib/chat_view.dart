library chatting;

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class ChatView extends StatefulWidget {

  final List<types.Message> messages;
  final types.User currentUser;

  final Function(types.Message message) onSendMessage;

  final ChatTheme theme;
  final Widget Function(
    Widget child, {
      required types.Message message,
      required bool nextMessageInGroup,
    }
  )? bubbleBuilder;
  final Widget Function(types.User)? nameBuilder;
  final InputOptions inputOptions;

  const ChatView({
    super.key,
    required this.messages,
    required this.currentUser,
    required this.onSendMessage,
    this.theme = const DefaultChatTheme(),
    this.bubbleBuilder,
    this.nameBuilder,
    required this.inputOptions,
  });

  @override
  State<ChatView> createState() => _ChatViewState();

}

class _ChatViewState extends State<ChatView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Chat(
    theme: widget.theme,
    bubbleBuilder: widget.bubbleBuilder,
    nameBuilder: widget.nameBuilder,
    inputOptions: widget.inputOptions,
    messages: widget.messages,
    onAttachmentPressed: _handleAttachmentPressed,
    onMessageTap: _handleMessageTap,
    onPreviewDataFetched: _handlePreviewDataFetched,
    onSendPressed: _handleSendPressed,
    showUserAvatars: true,
    showUserNames: true,
    user: widget.currentUser,
  );

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 144,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleImageSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Photo'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleFileSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('File'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      final message = types.FileMessage(
        author: widget.currentUser,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        mimeType: lookupMimeType(result.files.single.path!),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
      );

      widget.onSendMessage(message);
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: widget.currentUser,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      widget.onSendMessage(message);
    }
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final index =
          widget.messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
          (widget.messages[index] as types.FileMessage).copyWith(
            isLoading: true,
          );

          setState(() {
            widget.messages[index] = updatedMessage;
          });

          // TODO: check cache
          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final index =
          widget.messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
          (widget.messages[index] as types.FileMessage).copyWith(
            isLoading: null,
          );

          setState(() {
            widget.messages[index] = updatedMessage;
          });
        }
      }

      await OpenFilex.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
      types.TextMessage message,
      types.PreviewData previewData
  ) {
    final index = widget.messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (widget.messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      widget.messages[index] = updatedMessage;
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: widget.currentUser,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    widget.onSendMessage(textMessage);
  }

}

