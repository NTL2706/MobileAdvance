import 'package:final_project_advanced_mobile/constants/colors.dart';
import 'package:final_project_advanced_mobile/feature/auth/provider/authenticate_provider.dart';
import 'package:final_project_advanced_mobile/feature/home/views/home_page.dart';
import 'package:final_project_advanced_mobile/feature/intro/views/intro_page.dart';
import 'package:final_project_advanced_mobile/feature/profie/views/create_profile_page.dart';
import 'package:final_project_advanced_mobile/feature/profie/views/detail_profile_company_screen.dart';
import 'package:final_project_advanced_mobile/feature/profie/views/detail_profile_student_screen.dart';
import 'package:final_project_advanced_mobile/feature/profie/widgets/profile_list_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  bool isAccountListVisible = false;
  late AnimationController _controller;
  late Animation _animation;
  @override
  void initState() {
    // TODO: implement initState
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? role = context.read<AuthenticateProvider>().authenRepository.role;
    String? username =
        context.read<AuthenticateProvider>().authenRepository.username;
    Map<String, dynamic>? switchProfile;
    
    if (role == null || username == null) {
      Future.delayed(Duration(milliseconds: 200), () {
        context.read<AuthenticateProvider>().signOut();
        return IntroPage();
      });
    }

    if (role == "company") {
      switchProfile =
          context.read<AuthenticateProvider>().authenRepository.company;
      username = switchProfile?['companyName'];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        elevation: 0,
      ),
      body: Column( 
        children: [
          _appProfileBar(username),
          _appProfileAction(role!, username!, switchProfile),
        ],
      ),
    );
  }

  Widget _appProfileBar(String? username) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/logo.png"),
            radius: 40,
          ),
          SizedBox(height: 10.0),
          Column(
            children: [
              Text(
                username!,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("Profile"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _switchAccountAction(bool isAccountListVisible, String role, String username, Map<String, dynamic>? switchProfile  ){
    if (role == "student") {
      switchProfile =
          context.read<AuthenticateProvider>().authenRepository.company;
      username = switchProfile?['companyName'];
    } else {
      switchProfile =
          context.read<AuthenticateProvider>().authenRepository.student;
    }

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: isAccountListVisible ? 1.0 : 0.0,
      child: Visibility(
        visible: isAccountListVisible,
        child: Container(
          padding: const EdgeInsets.only(left: 12.0),
          child: Column(
            children: [
              switchProfile != null
                  ? ListTile(
                      leading: const CircleAvatar(
                        backgroundImage: AssetImage("assets/images/logo.png"),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(username),
                          if (role == 'student') Icon(Icons.home)
                        ],
                      ),
                      onTap: () async {
                        if (role == "student") {
                          await context
                              .read<AuthenticateProvider>()
                              .switchProfile(role: "company");
                        } else {
                          await context
                              .read<AuthenticateProvider>()
                              .switchProfile(role: "student");
                        }

                        await Navigator.of(context).pushAndRemoveUntil(
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const HomePage(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                const begin = Offset(0.0, 1.0);
                                const end = Offset.zero;
                                final tween = Tween(begin: begin, end: end);
                                final offsetAnimation = animation.drive(tween);
                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                );
                              },
                            ),
                            (route) => false);
                      },
                    )
                  : ListTile(
                      leading: Icon(Icons.add),
                      title: role == "student"
                          ? Text("Add company")
                          : Text("Add student"),
                      onTap: role == "student"
                          ? () {
                              createProfile("company");
                            }
                          : () {
                              createProfile("student");
                            },
                    )
            ],
          ),
        ),
      ),
    );
  }

  void createProfile(String role) async {
    print(role);
    await Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              CreateProfilePage(
            role: role,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ),
        (route) => false);
  }

  Widget _appProfileAction(String role, String username, Map<String, dynamic>? switchProfile) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          color: AppColors.backgroundColor,
        ),
        child: Column(
          children: [
            ProfileListTile(
              icon: Icons.account_circle,
              title: "Switch profile",
              onTap: () {
                print("Profile button clicked");
                setState(() {
                  isAccountListVisible = !isAccountListVisible;
                });
              },
            ),

            _switchAccountAction(isAccountListVisible, role, username, switchProfile),

            ProfileListTile(
              icon: Icons.person,
              title: "Profile",
              onTap: () {
                // move to profile screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    // builder: (context) => const DetailProfileCompanyScreen(),
                    builder: (context) => const DetailProfileStudentScreen(),
                  ),
                );
              },
            ),
            ProfileListTile(
              icon: Icons.settings,
              title: "Settings",
              onTap: () {
                print("Settings button clicked");
              },
            ),
            ProfileListTile(
              icon: Icons.logout,
              title: "Logout",
              onTap: () async {
                await context.read<AuthenticateProvider>().signOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/intro', (route) => false);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
