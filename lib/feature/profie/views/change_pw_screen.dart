// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, sized_box_for_whitespace

import 'package:final_project_advanced_mobile/feature/auth/constants/auth_result.dart';
import 'package:final_project_advanced_mobile/feature/auth/provider/authenticate_provider.dart';
import 'package:final_project_advanced_mobile/feature/auth/views/sign_up_by_category.dart';
import 'package:final_project_advanced_mobile/widgets/custom_textfield.dart';
import 'package:final_project_advanced_mobile/widgets/password_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class ChangePwScreen extends StatelessWidget {
  ChangePwScreen({super.key, required this.apiForLogin, required this.title});

  final String apiForLogin;
  final String title;
  TextEditingController oldPassword = TextEditingController();
  TextEditingController passwordSignInController = TextEditingController();
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
                    "Change password with StudentHub",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                PasswordFielddWidget(
                  controller: oldPassword,
                  title: "Old password",
                ),
                const SizedBox(
                  height: 10,
                ),
                PasswordFielddWidget(
                  controller: passwordSignInController,
                  title: "New password",
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: constraints.maxWidth / 2,
                  child: ElevatedButton(
                      onPressed: () async {
                        print(apiForLogin);
                        await context.read<AuthenticateProvider>().ChangePw(
                              oldPw: oldPassword.text.trim(),
                              newPw: passwordSignInController.text.trim(),
                            );
                        AuthResult result =
                            context.read<AuthenticateProvider>().state.result!;
                        if (result == AuthResult.success) {
                          await context.read<AuthenticateProvider>().signOut(
                            token: context.read<AuthenticateProvider>().authenRepository.token!
                          );
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/intro', (route) => false);
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
                              type: QuickAlertType.error);
                        }
                      },
                      child:
                          context.watch<AuthenticateProvider>().state.isLoading
                              ? CircularProgressIndicator()
                              : Text("Change password ${title.toUpperCase()}")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
