import 'package:final_project_advanced_mobile/feature/auth/views/sign_up_by_category.dart';
import 'package:final_project_advanced_mobile/widgets/custom_textfield.dart';
import 'package:final_project_advanced_mobile/widgets/password_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key, required this.apiForLogin, required this.title});

  final String apiForLogin;
  final String title;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("StudentHub"),
      ),
      body: Padding(
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
                  "Login with StudentHub",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                hintText: "Username or email",
              ),
              const SizedBox(
                height: 10,
              ),
              PasswordFielddWidget(),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: size.width / 2,
                child: ElevatedButton(
                    onPressed: () {
                      print(apiForLogin);
                    },
                    child: Text("LOGIN AS ${title.toUpperCase()}")),
              ),
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an Student Hub account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return SignUpByCategory();
                          },
                        ));
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
