import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/conversation_controller.dart';

final conversationController =
    ChangeNotifierProvider.autoDispose<ConversationController>(
        (ref) => ConversationController());
