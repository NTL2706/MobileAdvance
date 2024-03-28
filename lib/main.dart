import 'package:final_project_advanced_mobile/feature/auth/views/login.dart';
import 'package:final_project_advanced_mobile/feature/home/views/home_page.dart';
import 'package:final_project_advanced_mobile/feature/intro/views/intro_page.dart';
import 'package:final_project_advanced_mobile/feature/post_a_project/views/dash_board.dart';
import 'package:final_project_advanced_mobile/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      
      initialRoute: '/intro',
      routes: {
        '/intro':(context) => IntroPage(),
        '/home': (context) => HomePage()
      },
    );
  }
}
