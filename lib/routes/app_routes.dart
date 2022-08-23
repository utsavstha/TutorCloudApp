import 'package:tutor_cloud/ui/auth/login_ui.dart';
import 'package:tutor_cloud/ui/auth/signup_ui.dart';
import 'package:tutor_cloud/ui/dashboard/main_ui.dart';
import 'package:tutor_cloud/ui/dashboard/conversation_ui.dart';
import 'package:tutor_cloud/ui/videocall/videocall_ui.dart';

import '../ui/book/chat_ui.dart';
import '../ui/dashboard/conversation_ui.dart';
import '../ui/dashboard/dashboard_ui.dart';
import '../ui/profile/profile_ui.dart';
import 'app_pages.dart';

/// Provies static  variables for routing
class AppPages {
  static const initial = Routes.login;
  static final routes = {
    Routes.login: (context) => LoginPage(),
    Routes.signup: (context) => SignupUI(),
    Routes.dashboard: (context) => DashboardUI(),
    Routes.mainUI: (context) => MainUI(),
    Routes.profile: (context) => ProfileUI(),
    Routes.conversations: (context) => ConversationUI(),
    Routes.chat: (context) => ChatUI(),
    Routes.videocall: (context) => VideoCallUI(),
  };
}
