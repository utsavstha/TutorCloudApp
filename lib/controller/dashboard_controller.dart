import 'package:flutter/material.dart';
import 'package:tutor_cloud/model/dashboard_model.dart';

import '../network/http_requests.dart';
import '../utils/api_constants.dart';
import '../utils/api_response.dart';
import '../utils/save_data.dart';

class DashboardController extends ChangeNotifier {
  bool isLoading = true;
  var dashboardModel = <DashboardModel>[];
  String message = '';
  String resetUrl = '';
  late HttpNetworkRequest httpRequest;
  late ApiResponse apiResponse;

  DashboardController() {
    apiResponse = ApiResponse.loading(false);
    httpRequest = HttpNetworkRequest();
  }

  void getData() async {
    apiResponse = ApiResponse.loading(true);
    notifyListeners();

    try {
      var response = await httpRequest.get(ApiConstants.dashboardUrl);

      // if (response.)
      dashboardModel.clear();
      response.map((item) {
        dashboardModel.add(DashboardModel.fromJson(item));
      }).toList();

      apiResponse = ApiResponse.success(false, dashboardModel);

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
