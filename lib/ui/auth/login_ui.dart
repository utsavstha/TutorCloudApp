import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants.dart';
import '../../providers/auth_provider.dart';
import '../../routes/app_pages.dart';
import '../../utils/progress_dialog.dart';
import '../../utils/save_data.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  _login() {
    ref
        .read(authNotifierProvider)
        .login(emailController.text, passwordController.text);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    // if (SaveData.getRole() != "") {
    //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //     Navigator.pushNamed(context, Routes.mainUI);
    //   });
    // }
    SaveData.getRole().then((value) {
      print(value);
      if (value == "student") {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          Navigator.pushNamed(context, Routes.mainUI);
        });
      } else if (value == "teacher") {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          Navigator.pushNamed(context, Routes.conversations);
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final provider = ref.watch(authNotifierProvider);
            if (provider.apiResponse.isLoading) {
              return const ProgressDialog();
            } else if (provider.apiResponse.model != "false") {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                if (provider.apiResponse.model == "student") {
                  Navigator.pushNamed(context, Routes.mainUI);
                } else {
                  Navigator.pushNamed(context, Routes.conversations);
                }
              });

              return const ProgressDialog();
            } else {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          'Welcome \nback',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Sign in to continue',
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade600),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Text(
                          'Email',
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade600),
                        ),
                        TextField(
                          controller: emailController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Password',
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade600),
                        ),
                        TextField(
                          obscureText: true,
                          controller: passwordController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Forgot Password?',
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade900),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity, // <-- match_parent
                          height: 50,
                          child: TextButton(
                            style: flatButtonStyle,
                            onPressed: _login,
                            child: Text('Sign In'),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.signup);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey.shade600),
                          ),
                          Text(
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
          }),
        ),
      ),
    );
  }
}
