import 'package:final_project_advanced_mobile/feature/auth/constants/sigup_category.dart';
import 'package:final_project_advanced_mobile/feature/auth/views/login.dart';
import 'package:final_project_advanced_mobile/feature/profie/views/profile_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: const Color(0xFFCE5A67),
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
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/logo.png'), // Thay đổi đường dẫn ảnh
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Text(
                    'Build your product with high-skilled students'
                        .toUpperCase(),
                    style: const TextStyle(
                      color: Color.fromARGB(255, 252, 245, 237),
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24.0),
                  Text(
                    'Find and onboard best-skilled student for your product. Student works to gain experience & skills from real-world projects',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 252, 245, 237)
                          .withOpacity(0.5),
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24.0),
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
                            backgroundColor:
                                const Color.fromARGB(255, 244, 191, 150),
                            elevation: 8.0, // Điều chỉnh độ nâng
                            shadowColor: Colors.black, // Đặt màu đổ bóng
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  0.0), // Đặt giá trị để có góc bo tròn
                            ),
                            minimumSize: const Size(100.0, 50.0)),
                        child: const Text('Company',
                            style: TextStyle(
                                color: Color.fromARGB(255, 31, 23, 23))),
                      ),
                      const SizedBox(width: 24.0),
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
                            backgroundColor:
                                const Color.fromARGB(255, 244, 191, 150),
                            elevation: 8.0, // Điều chỉnh độ nâng
                            shadowColor: Colors.black, // Đặt màu đổ bóng
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  0.0), // Đặt giá trị để có góc bo tròn
                            ),
                            minimumSize: const Size(100.0, 50.0)),
                        child: const Text('Student',
                            style: TextStyle(
                                color: Color.fromARGB(255, 31, 23, 23))),
                      ),
                      // TODO: Test profile
                      const SizedBox(width: 24.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const ProfileScreen();
                            },
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 244, 191, 150),
                          elevation: 8.0, // setup config lift
                          shadowColor:
                              Colors.black, // setup config shadow color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                0.0), // setup config border radius
                          ),
                          minimumSize: const Size(100.0, 50.0),
                        ),
                        child: const Text('Profile',
                            style: TextStyle(
                                color: Color.fromARGB(255, 31, 23, 23))),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  // Câu giới thiệu khác không phải nút
                  const Text(
                    'StudentHub is university market place to connect high-skilled student and company on a real-world project',
                    style: TextStyle(fontSize: 14.0),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )));
  }
}
