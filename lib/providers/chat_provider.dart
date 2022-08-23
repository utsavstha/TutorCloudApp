import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/auth_controller.dart';
import '../controller/chat_controller.dart';

final chatProvider = ChangeNotifierProvider.autoDispose<ChatController>(
    (ref) => ChatController());
