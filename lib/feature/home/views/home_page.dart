import 'package:final_project_advanced_mobile/feature/post_a_project/views/dash_board.dart';
// ignore_for_file: prefer_const_constructors

import 'package:final_project_advanced_mobile/feature/auth/constants/sigup_category.dart';
import 'package:final_project_advanced_mobile/feature/auth/views/login.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() =>
      _HomePageState();
}

class _HomePageState
    extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> widgetOptions = <Widget>[
    DashBoard(),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Student Hub'),
        actions: [
          Padding(
            padding: EdgeInsets.all(8),
            child: IconButton(onPressed: () {
              
            },icon:Icon(Icons.person)),
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.amber),
            child: Center(
              child: widgetOptions[_selectedIndex],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 65,
                margin: const EdgeInsets.only(right: 24, left: 24, bottom: 24),
                decoration: BoxDecoration(
                  color: Colors.black, 
                  boxShadow: [
                  BoxShadow(
                      color: Colors.black.withAlpha(20),
                      blurRadius: 20,
                      spreadRadius: 10)
                ],
                borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: BottomNavigationBar(
                    backgroundColor: Colors.white,
                    items: const <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.business),
                        label: 'Business',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.school),
                        label: 'School',
                    ),
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'Build your product with high-skilled students'
                        .toUpperCase(),
                    style: TextStyle(
                      color: Color.fromARGB(255, 252, 245, 237),
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'Find and onboard best-skilled student for your product. Student works to gain experience & skills from real-world projects',
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
                        child: Text('Company',
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
                        child: Text('Student',
                            style: TextStyle(
                                color: Color.fromARGB(255, 31, 23, 23))),
                      ),
                    ],
                    currentIndex: _selectedIndex,
                    selectedItemColor: Colors.amber[800],
                    onTap: _onItemTapped,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}