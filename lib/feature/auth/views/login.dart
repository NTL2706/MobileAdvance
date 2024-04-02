// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, sized_box_for_whitespace

import 'package:final_project_advanced_mobile/feature/auth/provider/authenticate_provider.dart';
import 'package:final_project_advanced_mobile/feature/auth/views/sign_up_by_category.dart';
import 'package:final_project_advanced_mobile/widgets/custom_textfield.dart';
import 'package:final_project_advanced_mobile/widgets/password_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {

  LoginPage({super.key, required this.apiForLogin, required this.title});

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
              const CustomTextField(
                hintText: "Username or email",
              ),
              const SizedBox(
                height: 10,
              ),
              const PasswordFielddWidget(),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: size.width / 2,
                child: ElevatedButton(
                  onPressed: () {
                    print(apiForLogin);
                    context.read<AuthenticateProvider>().signInWithPassword(email: "volehoai070902@gmail.com", password: "123456", role: title);
                    Navigator.of(context).pushNamed('/home');
                    // Navigator.push(context, MaterialPageRoute(builder: (context) {
                    //   return HomePage();
                    // },));
                  }, 
                  child: Text("LOGIN AS ${title.toUpperCase()}")
                ),
              ),
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an Student Hub account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {

                            return SignUpByCategory();
                          },));
                        },
                        child: Text("Sign up", style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),),
                      )
                    ],
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
