import 'package:flutter/material.dart';
import 'package:tutor_cloud/model/conversation_model.dart';

import '../network/http_requests.dart';
import '../utils/api_constants.dart';
import '../utils/api_response.dart';
import '../utils/save_data.dart';

class ConversationController extends ChangeNotifier {
  bool isLoading = true;

  String message = '';
  String resetUrl = '';
  late HttpNetworkRequest httpRequest;
  late ApiResponse apiResponse;

  var conversationModel = <ConversationModel>[];

  ConversationController() {
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

  void getConversations() async {
    apiResponse = ApiResponse.loading(true);
    notifyListeners();

    try {
      String url = ApiConstants.conversationsTeacher;
      int id = await SaveData.getId();
      String role = await SaveData.getRole();
      if (role == "student") {
        url = ApiConstants.conversationsStudent;
      }
      var finalUrl = url + "$id";
      print(finalUrl);
      var response = await httpRequest.get(finalUrl);

      // if (response.)
      conversationModel.clear();
      response.map((item) {
        conversationModel.add(ConversationModel.fromJson(item));
      }).toList();

      apiResponse = ApiResponse.success(false, conversationModel);

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
}
