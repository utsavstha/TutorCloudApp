import 'package:flutter/material.dart';
import 'package:tutor_cloud/model/conversation_model.dart';

import '../model/chat_message_model.dart';
import '../network/http_requests.dart';
import '../utils/api_constants.dart';
import '../utils/api_response.dart';
import '../utils/save_data.dart';

class ChatController extends ChangeNotifier {
  bool isLoading = true;

  String message = '';
  String resetUrl = '';
  late HttpNetworkRequest httpRequest;
  late ApiResponse apiResponse;

  var chatModel = <ChatModel>[];

  ChatController() {
    apiResponse = ApiResponse.loading(false);
    httpRequest = HttpNetworkRequest();
  }
  void start(String id) async {
    apiResponse = ApiResponse.loading(true);
    notifyListeners();

    try {
      final Map<String, dynamic> data = {
        "teacher_id": id,
        "student_id": SaveData.getId(),
      };
      var response = await httpRequest.post(ApiConstants.conversation, data);

      apiResponse = ApiResponse.success(false, "success");

      // print(apiResponse);
      // return Success(true);
    } catch (e) {
      print(e);
      // return Failure('Could not login');
      apiResponse = ApiResponse.error(false, "Error");
    }

    notifyListeners();
  }

  void getChatMesssages(int id) async {
    apiResponse = ApiResponse.loading(true);
    notifyListeners();

    try {
      String url = ApiConstants.chatMessage;

      var finalUrl = url + "$id";
      var response = await httpRequest.get(finalUrl);

      // if (response.)
      chatModel.clear();
      response.map((item) {
        chatModel.add(ChatModel.fromJson(item));
      }).toList();

      apiResponse = ApiResponse.success(false, chatModel);

      // print(apiResponse);
      // return Success(true);
    } catch (e) {
      print(e);
      // return Failure('Could not login');
      apiResponse = ApiResponse.error(false, "Error");
    }

    notifyListeners();
  }

  void register(String email, String password, String firstName,
      String lastName, String role) async {
    apiResponse = ApiResponse.loading(true);
    notifyListeners();

    try {
      final Map<String, dynamic> data = {
        "email": email,
        "password": password,
        "first_name": firstName,
        "last_name": lastName,
        "avatarUrl": "https://i.pravatar.cc/150?img=68",
        "password_confirmation": password,
        "role": role
      };
      var response = await httpRequest.post(ApiConstants.signupUrl, data);

      // if (response.)

      // SaveData.saveData(
      //     response['token']['token'],
      //     response['user']['email'],
      //     response['user']['first_name'] + " " + response['user']['last_name'],
      //     response['user']['role']);
      apiResponse = ApiResponse.success(false, "success");

      // print(apiResponse);
      // return Success(true);
    } catch (e) {
      print(e);
      // return Failure('Could not login');
      apiResponse = ApiResponse.error(false, "Error");
    }

    notifyListeners();
  }

  void shareRoom(String roomId, String conversationId) async {
    try {
      // HttpNetworkRequest httpRequest = HttpNetworkRequest();
      String url = ApiConstants.shareRoom;
      final Map<String, dynamic> data = {
        "roomId": roomId,
        "conversationId": conversationId,
      };
      // var dio = Dio();
      // dio.post(url, data: data);
      await httpRequest.post(url, data);
    } catch (e) {
      print(e);
      // ret
      //}urn Fa
    }
  }
}
