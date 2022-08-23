import 'package:flutter/material.dart';

import '../network/http_requests.dart';
import '../utils/api_constants.dart';
import '../utils/api_response.dart';
import '../utils/save_data.dart';

class AuthController extends ChangeNotifier {
  bool isLoading = true;

  String message = '';
  String resetUrl = '';
  late HttpNetworkRequest httpRequest;
  late ApiResponse apiResponse;

  AuthController() {
    apiResponse = ApiResponse.loading(false);
    httpRequest = HttpNetworkRequest();
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
      SaveData.saveRole(response['user']['role'], response['user']['id'],
          response['user']['first_name'] + " " + response['user']['last_name']);

      // if (response.)

      // SaveData.saveData(
      //     response['token']['token'],
      //     response['user']['email'],
      //     response['user']['first_name'] + " " + response['user']['last_name'],
      //     response['user']['role']);
      apiResponse = ApiResponse.success(false, response['user']['role']);

      // print(apiResponse);
      // return Success(true);
    } catch (e) {
      print(e);
      // return Failure('Could not login');
      apiResponse = ApiResponse.error(false, "Error");
    }

    notifyListeners();
  }

  void login(String email, String password) async {
    apiResponse = ApiResponse.loading(true);
    notifyListeners();

    try {
      final Map<String, dynamic> data = {"email": email, "password": password};
      var response = await httpRequest.post(ApiConstants.loginUrl, data);

      // if (response.)
      if (response.containsKey('token')) {
        SaveData.saveRole(
            response['user']['role'],
            response['user']['id'],
            response['user']['first_name'] +
                " " +
                response['user']['last_name']);

        apiResponse = ApiResponse.success(false, response['user']['role']);
      } else {
        apiResponse = ApiResponse.success(false, "failed");
      }

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
