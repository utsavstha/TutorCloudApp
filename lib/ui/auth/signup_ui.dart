import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants.dart';
import '../../providers/auth_provider.dart';
import '../../routes/app_pages.dart';
import '../../utils/progress_dialog.dart';

class SignupUI extends ConsumerStatefulWidget {
  const SignupUI({Key? key}) : super(key: key);

  @override
  ConsumerState<SignupUI> createState() => _SignupUIState();
}

class _SignupUIState extends ConsumerState<SignupUI> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  var isStudent = true;

  _register() {
    String role = isStudent ? "student" : "teacher";
    ref.read(authNotifierProvider).register(
        emailController.text,
        passwordController.text,
        firstNameController.text,
        lastNameController.text,
        role);
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
            } else if (provider.apiResponse.model == "success") {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.pushNamed(context, Routes.mainUI);
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
                        const Text(
                          'Welcome \nuser',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Sign up to join',
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade600),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Text(
                          'First Name',
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade600),
                        ),
                        TextField(
                          controller: firstNameController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Last Name',
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade600),
                        ),
                        TextField(
                          controller: lastNameController,
                        ),
                        const SizedBox(
                          height: 20,
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
                          'Confirm Password',
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade600),
                        ),
                        TextField(
                          controller: confirmPasswordController,
                          obscureText: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              'Student',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade600),
                            ),
                            Checkbox(
                              checkColor: Colors.white,
                              value: isStudent,
                              onChanged: (bool? value) {
                                setState(() {
                                  isStudent = value!;
                                });
                              },
                            ),
                            Text(
                              'Teacher',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade600),
                            ),
                            Checkbox(
                              checkColor: Colors.white,
                              value: !isStudent,
                              onChanged: (bool? value) {
                                setState(() {
                                  isStudent = !value!;
                                });
                              },
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity, // <-- match_parent
                          height: 50,
                          child: TextButton(
                            style: flatButtonStyle,
                            onPressed: _register,
                            child: Text('Sign Up'),
                          ),
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Have an account?',
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey.shade600),
                          ),
                          Text(
                            'Sign In',
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
