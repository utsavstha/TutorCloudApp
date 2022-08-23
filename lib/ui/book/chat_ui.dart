import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:tutor_cloud/ui/profile/widgets/review_item.dart';
import 'package:tutor_cloud/utils/api_constants.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../../model/chat_message_model.dart';
import '../../network/http_requests.dart';
import '../../routes/app_pages.dart';
import '../../utils/save_data.dart';
import '../dashboard/widgets/conversation_item.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatUI extends StatefulWidget {
  const ChatUI({Key? key}) : super(key: key);

  @override
  State<ChatUI> createState() => _ChatUIState();
}

class _ChatUIState extends State<ChatUI> {
  List<types.Message> _messages = [];
  late types.User _user;
  late IO.Socket socket;
  String conversationId = "";
  String name = "";
  String receiverId = "";
  var loaded = false;
  @override
  void initState() {
    super.initState();
    initSocket();
    // SaveData.getId().then((value) {
    //   userId = value;
    // });
  }

  Future<void> initSocket() async {
    print('Connecting to chat service');
    // String registrationToken = await getFCMToken();
    socket = IO.io(ApiConstants.baseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'query': {'userName': "test", 'registrationToken': "test"}
    });
    socket.connect();
    socket.onConnect((_) {
      print('connected to websocket');
    });
  }

  _handleCall(conversationId) {
    print("call_$conversationId");
    SaveData.getRole().then((value) {
      print(value);
      if (value == "teacher") {
        socket.on("call_$conversationId", (message) {
          print(message);
          _gotoChat(message, conversationId);
        });
      }
    });
  }

  _gotoChat(String roomId, String conversationId) {
    Navigator.pushNamed(context, Routes.videocall, arguments: {
      "roomId": roomId,
      "conversationId": conversationId,
    });
  }

  void _handleSocketMessage(conversationId) {
    socket.on(conversationId, (message) {
      print(message);
      var item = ChatModel.fromJson(message);
      var textMessage = types.TextMessage(
        author: types.User(id: item.userOne.toString()),
        createdAt: DateTime.parse(item.createdAt).millisecondsSinceEpoch,
        id: item.id.toString(),
        text: item.message,
      );
      _addMessage(textMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    final name = args['name'] as String;
    final email = args['email'] as String;
    final avatar = args['avatar'] as String;
    final conversationId = args['conversation_id'] as String;
    final userId = args['user_id'] as String;
    receiverId = args['receiver_id'] as String;
    _user = types.User(id: userId.toString());
    this.name = name;
    this.conversationId = conversationId;
    _handleSocketMessage(conversationId);
    if (!loaded) {
      loaded = true;
      _loadMessages();
      _handleCall(conversationId);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Now"),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.call,
              color: Colors.white,
            ),
            onPressed: () {
              // Navigator.pushNamed(context, Routes.videocall);
              Navigator.pushNamed(context, Routes.videocall, arguments: {
                "roomId": "",
                "conversationId": conversationId,
              });
            },
          )
        ],
      ),
      body: SafeArea(
        child: Chat(
          isLastPage: false,
          messages: _messages,
          onSendPressed: _handleSendPressed,
          showUserAvatars: true,
          showUserNames: true,
          user: _user,
        ),
      ),
    );
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  void _addMessage(types.Message message) {
    // setState(() {
    //   _messages.insert(0, message);
    // });
    _loadMessages();
  }

  void _handleSendPressed(types.PartialText message) {
    _sendMessage(message.text);
  }

  void _sendMessage(String message) async {
    try {
      HttpNetworkRequest httpRequest = HttpNetworkRequest();
      String url = ApiConstants.chatMessage;
      final Map<String, dynamic> data = {
        "user_one": _user.id,
        "user_two": receiverId,
        "user_one_name": "Utsav Shrestha",
        "user_two_name": name,
        "message": message,
        "conversation_id": conversationId
      };
      var response = await httpRequest.post(url, data);
      num id = response['id'];
      final textMessage = types.TextMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: id.toString(),
        text: message,
      );

      _addMessage(textMessage);
      // if (response.)

      // print(apiResponse);
      // return Success(true);
    } catch (e) {
      print(e);
      // return Failure('Could not login');
    }
  }

  void _loadMessages() async {
    var chatModel = <ChatModel>[];

    try {
      HttpNetworkRequest httpRequest = HttpNetworkRequest();
      String url = ApiConstants.chatMessage;

      var finalUrl = "$url$conversationId";
      print(finalUrl);
      var response = await httpRequest.get(finalUrl);

      // if (response.)
      chatModel.clear();
      response.map((item) {
        chatModel.add(ChatModel.fromJson(item));
      }).toList();
      List<types.Message> messages = [];
      for (var i = 0; i < chatModel.length; i++) {
        var item = chatModel[i];
        messages.add(types.TextMessage(
          author: types.User(id: item.userOne.toString()),
          createdAt: DateTime.parse(item.createdAt).millisecondsSinceEpoch,
          id: item.id.toString(),
          text: item.message,
        ));
        // _messages.add(Message(author: types.User(id: item.userOne.toString(), firstName: item.userOneName), id: item.id.toString(), repliedMessage: Message(message: item.message, emojiEnlargementBehavior: false, hideBackgroundOnEmojiMessages: false, isTextMessageTextSelectable: true, messageWidth: 1920, previewTapOptions: null, roundBorder: true, showAvatar: false, showName: true, showStatus: false,, showUserAvatars: false, textMessageOptions: null, usePreviewData: false, ) ));
      }
      setState(() {
        _messages = messages;
      });
      // print(apiResponse);
      // return Success(true);
    } catch (e) {
      print(e);
      // return Failure('Could not login');
    }
  }
}
