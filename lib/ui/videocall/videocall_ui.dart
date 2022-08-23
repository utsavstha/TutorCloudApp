import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:tutor_cloud/providers/chat_provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../network/http_requests.dart';
import '../../utils/api_constants.dart';
import '../../utils/signaling.dart';

class VideoCallUI extends ConsumerStatefulWidget {
  VideoCallUI({Key? key}) : super(key: key);

  @override
  _VideoCallUIPageState createState() => _VideoCallUIPageState();
}

class _VideoCallUIPageState extends ConsumerState<VideoCallUI> {
  Signaling signaling = Signaling();
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  String? roomId;
  TextEditingController textEditingController = TextEditingController(text: '');
  String conversationId = "";
  bool isLoaded = false;
  late IO.Socket socket;
  bool roomCreated = false;
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

  @override
  void initState() {
    super.initState();
    initSocket();
    _localRenderer.initialize();
    _remoteRenderer.initialize();
    signaling.onAddRemoteStream = ((stream) {
      _remoteRenderer.srcObject = stream;
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  _prepare(String roomId) {
    signaling.openUserMedia(_localRenderer, _remoteRenderer);

    if (roomId != "" && !roomCreated) {
      _joinRoom(roomId);
    } else {
      _createRoom();
    }
  }

  _createRoom() async {
    roomId = await signaling.createRoom(_remoteRenderer);
    roomCreated = true;
    // setState(() {});
    // ref.read(chatProvider).shareRoom(roomId!, conversationId);
    // String url = ApiConstants.shareRoom;
    final Map<String, dynamic> data = {
      "roomId": roomId,
      "conversationId": conversationId,
    };
    socket.emit("shareRoom", data);

    // var dio = Dio();
    // dio.post(url, data: data);
    // _shareRoomid(roomId!);
    // textEditingController.text = roomId!;
  }

  _joinRoom(String roomId) async {
    await signaling.joinRoom(
      roomId,
      _remoteRenderer,
    );
    setState(() {});
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    final roomId = args['roomId'] as String;
    conversationId = args['conversationId'] as String;
    if (!isLoaded) {
      isLoaded = true;
      _prepare(roomId);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("In Room"),
      ),
      body: Column(
        children: [
          SizedBox(height: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ElevatedButton(
              //   onPressed: () {
              //     signaling.openUserMedia(_localRenderer, _remoteRenderer);
              //   },
              //   child: Text("Open camera & microphone"),
              // ),
              // SizedBox(
              //   width: 8,
              // ),
              // ElevatedButton(
              //   onPressed: () async {
              //     roomId = await signaling.createRoom(_remoteRenderer);
              //     textEditingController.text = roomId!;
              //     setState(() {});
              //   },
              //   child: Text("Create room"),
              // ),
              // SizedBox(
              //   width: 8,
              // ),
              // ElevatedButton(
              //   onPressed: () {
              //     // Add roomId
              //     signaling.joinRoom(
              //       textEditingController.text,
              //       _remoteRenderer,
              //     );
              //   },
              //   child: Text("Join room"),
              // ),
              SizedBox(
                width: 8,
              ),
              ElevatedButton(
                onPressed: () {
                  signaling.hangUp(_localRenderer);
                  Navigator.pop(context);
                },
                child: Text("Hangup"),
              )
            ],
          ),
          SizedBox(height: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: RTCVideoView(_localRenderer, mirror: true)),
                  Expanded(child: RTCVideoView(_remoteRenderer)),
                ],
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Text("Join the following Room: "),
          //       Flexible(
          //         child: TextFormField(
          //           controller: textEditingController,
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          SizedBox(height: 8)
        ],
      ),
    );
  }
}
