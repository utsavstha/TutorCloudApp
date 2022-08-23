import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutor_cloud/model/conversation_model.dart';
import 'package:tutor_cloud/providers/converstaion_provider.dart';
import 'package:tutor_cloud/utils/no_data.dart';

import '../../routes/app_pages.dart';
import '../../utils/api_constants.dart';
import '../../utils/progress_dialog.dart';
import '../../utils/save_data.dart';
import 'widgets/conversation_item.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ConversationUI extends ConsumerStatefulWidget {
  const ConversationUI({Key? key}) : super(key: key);

  @override
  ConsumerState<ConversationUI> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends ConsumerState<ConversationUI> {
  late IO.Socket socket;
  @override
  void initState() {
    super.initState();
    initSocket();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(conversationController).getConversations();
    });
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
    int uid = await SaveData.getId();
    socket.on("call_$uid", (message) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ref.read(conversationController).getConversations();
      });
    });
  }

  _gotoChat(ConversationModel model) async {
    String role = await SaveData.getRole();
    var user_id = -1;
    var receiver_id = -1;
    if (role == "student") {
      user_id = model.student_id;
      receiver_id = model.teacher_id;
    } else {
      user_id = model.teacher_id;
      receiver_id = model.student_id;
    }

    Navigator.pushNamed(context, Routes.chat, arguments: {
      "name": model.firstName + model.lastName,
      "email": model.email,
      "avatar": model.avatarUrl,
      "conversation_id": model.id.toString(),
      "user_id": user_id.toString(),
      "receiver_id": receiver_id.toString(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Connect',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final provider = ref.watch(conversationController);
              if (provider.apiResponse.isLoading) {
                return const ProgressDialog();
              } else if (provider.apiResponse.model != null &&
                  provider.apiResponse.model != "false") {
                return Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: provider.apiResponse.model.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          _gotoChat(provider.apiResponse.model[index]);
                        },
                        child: ConversationItem(
                          imageUrl: provider.apiResponse.model[index].avatarUrl,
                          name: provider.apiResponse.model[index].firstName +
                              provider.apiResponse.model[index].lastName,
                          message: "",
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const NoData();
              }
            })
          ],
        ),
      )),
    );
  }
}

// Column(
//               children: [
//                 ConversationItem(
//                   imageUrl: "https://i.pravatar.cc/150?img=22",
//                   name: "Utsav Shrestha",
//                   message: "Very helpful",
//                 )
//               ],
//             )