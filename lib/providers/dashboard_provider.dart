import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/dashboard_controller.dart';

final dashboardNotifierProvider =
    ChangeNotifierProvider.autoDispose<DashboardController>(
        (ref) => DashboardController());
