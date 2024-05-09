// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, sized_box_for_whitespace

import 'package:final_project_advanced_mobile/feature/auth/constants/auth_result.dart';
import 'package:final_project_advanced_mobile/feature/auth/provider/authenticate_provider.dart';
import 'package:final_project_advanced_mobile/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final String apiForLogin = "";
  final String title = "";
  final TextEditingController emailSignInController = TextEditingController();
  final TextEditingController passwordSignInController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    print(context.watch<AuthenticateProvider>().state.isLoading);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("StudentHub"),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/logo.png"),
                  radius: 100,
                ),
                const Center(
                  child: Text(
                    "Forgot password with StudentHub",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  onChanged: (p0) {},
                  controller: emailSignInController,
                  hintText: "Username or email",
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: constraints.maxWidth / 2,
                  child: ElevatedButton(
                      onPressed: () async {
                        await context
                            .read<AuthenticateProvider>()
                            .forgotPassword(
                              email: emailSignInController.text.trim(),
                            );
                        AuthResult result =
                            context.read<AuthenticateProvider>().state.result!;
                        if (result == AuthResult.success) {
                          Navigator.of(context).pop();
                          print("success");
                        } else {
                          await QuickAlert.show(
                            text: context
                                .read<AuthenticateProvider>()
                                .state
                                .message,
                            confirmBtnText: "OK",
                            cancelBtnText: "CANCEL",
                            onConfirmBtnTap: () {
                              Navigator.of(context).pop();
                            },
                            onCancelBtnTap: () {
                              Navigator.of(context).pop();
                            },
                            context: context,
                            showCancelBtn: true,
                            type: QuickAlertType.error,
                          );
                        }
                      },
                      child:
                          context.watch<AuthenticateProvider>().state.isLoading
                              ? CircularProgressIndicator()
                              : Text("Get Password")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
