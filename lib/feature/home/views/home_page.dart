import 'package:final_project_advanced_mobile/back_service.dart';
import 'package:final_project_advanced_mobile/constants/colors.dart';
import 'package:final_project_advanced_mobile/feature/auth/provider/authenticate_provider.dart';
import 'package:final_project_advanced_mobile/feature/chat/provider/chat_provider.dart';
import 'package:final_project_advanced_mobile/feature/chat/views/all_user.dart';
import 'package:final_project_advanced_mobile/feature/dashboard/views/dashboard.dart';
import 'package:final_project_advanced_mobile/feature/notification/views/notification_page.dart';
import 'package:final_project_advanced_mobile/feature/profie/views/create_profile_page.dart';
import 'package:final_project_advanced_mobile/feature/profie/views/profile_screen.dart';
import 'package:final_project_advanced_mobile/feature/projects/views/all_projects.dart';
import 'package:final_project_advanced_mobile/languages/language.dart';
import 'package:final_project_advanced_mobile/services/theme_service.dart';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  late AuthenticateProvider authenticateProvider;
  late ChatProvider chatProvider;

  @override
  void initState() {
    authenticateProvider = context.read<AuthenticateProvider>();
    chatProvider = context.read<ChatProvider>();
    print(authenticateProvider.authenRepository.id);
    print(authenticateProvider.authenRepository.username);

    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      print(state);
      // FlutterBackgroundService().invoke("setAsBackground", {
      //   "token": authenticateProvider.authenRepository.token,
      //   "userId": authenticateProvider.authenRepository.id
      // });
    }
    if (state == AppLifecycleState.resumed) {
      print(state);
      // FlutterBackgroundService().invoke("setAsForeground", {
      //   "token": authenticateProvider.authenRepository.token,
      //   "userId": authenticateProvider.authenRepository.id
      // });
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: context.read<AuthenticateProvider>().getUserInf(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            decoration: BoxDecoration(
                color: Get.isDarkMode
                    ? Themes.backgroundDark
                    : Themes.backgroundLight),
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

class HomeBody extends StatefulWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> widgetOptions = <Widget>[
    ProjectPage(),
    DashBoard(),
    MessageWidget(),
    NotificationPage(),
  ];
  int? selectedIndex = 0;

  HomeBody({super.key, this.selectedIndex});
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
        backgroundColor:
            Get.isDarkMode ? Themes.backgroundDark : Themes.backgroundLight,
        title: const Text('Student Hub'),
        actions: [
          Padding(
            padding: EdgeInsets.all(8),
            child: IconButton(
                onPressed: () {
                  ThemeService().switchTheme();
                },
                icon: Icon(Icons.lightbulb)),
          ),
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
            decoration: BoxDecoration(
                color: Get.isDarkMode
                    ? Themes.backgroundDark
                    : Themes.backgroundLight),
            child: Center(
              child: HomeBody.widgetOptions[_selectedIndex],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(right: 5, left: 5, bottom: 10, top: 5),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Get.isDarkMode
                    ? Colors.black.withOpacity(0.5)
                    : Colors.grey.withOpacity(0.5),
                blurRadius: 10,
                spreadRadius: 5)
          ],
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: Languages.of(context)!.projects,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: Languages.of(context)!.dashboard,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.message),
                label: Languages.of(context)!.message,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: Languages.of(context)!.alert,
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Themes.selectColor,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
