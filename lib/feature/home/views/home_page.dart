import 'package:final_project_advanced_mobile/feature/auth/provider/authenticate_provider.dart';
import 'package:final_project_advanced_mobile/feature/chat/views/all_user.dart';
import 'package:final_project_advanced_mobile/feature/dashboard/views/dashboard.dart';
import 'package:final_project_advanced_mobile/feature/notification/views/notification_page.dart';
import 'package:final_project_advanced_mobile/feature/profie/views/create_profile_page.dart';
import 'package:final_project_advanced_mobile/feature/profie/views/profile_screen.dart';
import 'package:final_project_advanced_mobile/feature/projects/views/all_projects.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {

    return FutureBuilder<Map<String, dynamic>>(
      future: context.read<AuthenticateProvider>().getUserInf(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white
            ),
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            ),
          );
        } else {
          // print(snapshot.data?['company']);
          Map<String, dynamic>? student = snapshot.data?['student'];
          Map<String, dynamic>? company = snapshot.data?['company'];

          final role =
              context.read<AuthenticateProvider>().authenRepository.role;
          print(context.read<AuthenticateProvider>().authenRepository.token);
          if (role == "student" && student == null) {
            return CreateProfilePage(
              role: role!,
            );
          }
          if (role == "company" && company == null) {
            return CreateProfilePage(
              role: role!,
            );
          }

          return HomeBody();
        }
      },
    );
  }
}

class HomeBody extends StatefulWidget{
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> widgetOptions = <Widget>[
    ProjectPage(),
    DashBoard(),
    MessageWidget(),
    NoticationPage(),
  ];
  int? selectedIndex = 0;

  HomeBody({
    super.key,
    this.selectedIndex
    });
  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
   int _selectedIndex = 0;
  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              scrolledUnderElevation: 0,
              backgroundColor: Colors.white,
              title: const Text('Student Hub'),
              actions: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return ProfileScreen();
                          },
                        ));
                      },
                      icon: Icon(Icons.person)),
                )
              ],
            ),
            body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Center(
                    child: HomeBody.widgetOptions[_selectedIndex],
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Container(
              margin:
                  const EdgeInsets.only(right: 5, left: 5, bottom: 10, top: 5),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withAlpha(20),
                      blurRadius: 10,
                      spreadRadius: 5)
                ],
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Project',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.dashboard),
                      label: 'Dashboard',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.message),
                      label: 'Message',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.notifications),
                      label: 'Alert',
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  selectedItemColor: Colors.blue,
                  onTap: _onItemTapped,
                ),
              ),
            ),
          );
  }
}
