import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/auth_controller.dart';

final authNotifierProvider = ChangeNotifierProvider.autoDispose<AuthController>(
    (ref) => AuthController());
