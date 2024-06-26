import 'package:final_project_advanced_mobile/feature/auth/constants/sigup_category.dart';
import 'package:final_project_advanced_mobile/feature/auth/provider/authenticate_provider.dart';
import 'package:final_project_advanced_mobile/feature/auth/views/login.dart';
import 'package:final_project_advanced_mobile/feature/home/views/home_page.dart';
import 'package:final_project_advanced_mobile/languages/language.dart';
import 'package:final_project_advanced_mobile/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String? role = context.read<AuthenticateProvider>().authenRepository.role;
    if (role != null) {
      Future.delayed(
        Duration(milliseconds: 100),
        () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home', (route) => false);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print("/intro");

    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
            color: Color(0xFFCE5A67),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 2 câu giới thiệu
                  Container(
                    width: 250.0,
                    height: 250.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/logo.png'), // Thay đổi đường dẫn ảnh
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    Languages.of(context)!.slotGen.toUpperCase(),
                    style: TextStyle(
                      color: Color.fromARGB(255, 252, 245, 237),
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    Languages.of(context)!.appDescription,
                    style: TextStyle(
                      color:
                          Color.fromARGB(255, 252, 245, 237).withOpacity(0.5),
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.0),
                  // 2 nút company và student với đổ bóng đen màu vàng
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return LoginPage(
                                apiForLogin:
                                    "api for ${StudentHubCategorySignUp.company.name}",
                                title: StudentHubCategorySignUp.company.name,
                              );
                            },
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 244, 191, 150),
                            elevation: 8.0, // Điều chỉnh độ nâng
                            shadowColor: Colors.black, // Đặt màu đổ bóng
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  0.0), // Đặt giá trị để có góc bo tròn
                            ),
                            minimumSize: Size(100.0, 50.0)),
                        child: Text(Languages.of(context)!.company,
                            style: TextStyle(
                                color: Color.fromARGB(255, 31, 23, 23))),
                      ),
                      SizedBox(width: 24.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return LoginPage(
                                apiForLogin:
                                    "api for ${StudentHubCategorySignUp.student.name}",
                                title: StudentHubCategorySignUp.student.name,
                              );
                            },
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 244, 191, 150),
                            elevation: 8.0, // Điều chỉnh độ nâng
                            shadowColor: Colors.black, // Đặt màu đổ bóng
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  0.0), // Đặt giá trị để có góc bo tròn
                            ),
                            minimumSize: Size(100.0, 50.0)),
                        child: Text(Languages.of(context)!.student,
                            style: TextStyle(
                                color: Color.fromARGB(255, 31, 23, 23))),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.0),
                  // Câu giới thiệu khác không phải nút
                  Text(
                    Languages.of(context)!.appDescription2,
                    style: TextStyle(fontSize: 14.0),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )));
  }
}
