import 'package:final_project_advanced_mobile/back_service.dart';
import 'package:final_project_advanced_mobile/feature/auth/constants/auth_result.dart';
import 'package:final_project_advanced_mobile/feature/auth/provider/authenticate_provider.dart';
import 'package:final_project_advanced_mobile/feature/auth/views/forgot_password.dart';
import 'package:final_project_advanced_mobile/feature/auth/views/sign_up_by_category.dart';
import 'package:final_project_advanced_mobile/feature/chat/provider/chat_provider.dart';
import 'package:final_project_advanced_mobile/languages/language.dart';
import 'package:final_project_advanced_mobile/widgets/custom_textfield.dart';
import 'package:final_project_advanced_mobile/widgets/password_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key, required this.apiForLogin, required this.title});

  final String apiForLogin;
  final String title;
  TextEditingController emailSignInController = TextEditingController();
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
                Center(
                  child: Text(
                    Languages.of(context)!.login,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  onChanged: (p0) {},
                  controller: emailSignInController,
                  hintText: Languages.of(context)!.email,
                ),
                const SizedBox(
                  height: 10,
                ),
                PasswordFielddWidget(
                  controller: passwordSignInController,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: constraints.maxWidth * 0.7,
                  child: ElevatedButton(
                      onPressed: () async {
                        print(apiForLogin);
                        await context
                            .read<AuthenticateProvider>()
                            .signInWithPassword(
                                email: emailSignInController.text.trim(),
                                password: passwordSignInController.text.trim(),
                                role: title);
                        AuthResult result =
                            context.read<AuthenticateProvider>().state.result!;
                        if (result == AuthResult.success) {
                          // await initializeService();
                          final service = FlutterBackgroundService();
                          bool isRunning = await service.isRunning();
                          if (isRunning) {
                            print("stop");
                            // service.invoke("stopService");
                            service.invoke("setAsForeground", {
                              "token": context
                                  .read<AuthenticateProvider>()
                                  .authenRepository
                                  .token,
                              "userId": context
                                  .read<AuthenticateProvider>()
                                  .authenRepository
                                  .id
                            });
                          } else {
                            print("start");
                            await service.startService();
                            service.invoke("setAsForeground", {
                              "token": context
                                  .read<AuthenticateProvider>()
                                  .authenRepository
                                  .token,
                              "userId": context
                                  .read<AuthenticateProvider>()
                                  .authenRepository
                                  .id
                            });
                          }
                          // await service.startService();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            '/home',
                            (route) => false,
                          );
                        } else {
                          await QuickAlert.show(
                              text: context
                                  .read<AuthenticateProvider>()
                                  .state
                                  .message,
                              confirmBtnText: Languages.of(context)!.oke,
                              cancelBtnText: Languages.of(context)!.cancel,
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
                      child: context
                              .watch<AuthenticateProvider>()
                              .state
                              .isLoading
                          ? CircularProgressIndicator()
                          : Text(
                              "${Languages.of(context)!.login} ${title.toUpperCase()}")),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.03,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${Languages.of(context)!.forgotPassword}? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ForgotPasswordPage();
                            },
                          ));
                        },
                        child: Text(
                          Languages.of(context)!.getIt,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.03,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(Languages.of(context)!.dontAccount + " "),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return SignUpByCategory();
                            },
                          ));
                        },
                        child: Text(
                          Languages.of(context)!.register,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
