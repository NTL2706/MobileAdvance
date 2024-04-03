import 'package:final_project_advanced_mobile/constants/colors.dart';
import 'package:final_project_advanced_mobile/feature/auth/provider/authenticate_provider.dart';
import 'package:final_project_advanced_mobile/feature/intro/views/intro_page.dart';
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

class _ProfileScreenState extends State<ProfileScreen> {
  bool isAccountListVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        elevation: 0,
      ),
      body: Column(
        children: [
          _appProfileBar(),
          _appProfileAction(),
        ],
      ),
    );
  }

  Widget _appProfileBar() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: const Column(
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
                "Nguyen Van A",
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

  Widget _switchAccountAction(bool isAccountListVisible) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: isAccountListVisible ? 1.0 : 0.0,
      child: Visibility(
        visible: isAccountListVisible,
        child: Container(
          padding: const EdgeInsets.only(left: 12.0),
          child: Column(
            children: [
              ListTile(
                leading: const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/logo.png"),
                ),
                title: const Text("User 1"),
                onTap: () {
                  print("Account 1 selected");
                },
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/logo.png"),
                ),
                title: const Text("User 2"),
                onTap: () {
                  print("Account 2 selected");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appProfileAction() {
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
              title: "Switch account",
              onTap: () {
                print("Profile button clicked");
                setState(() {
                  isAccountListVisible = !isAccountListVisible;
                });
              },
            ),
            _switchAccountAction(isAccountListVisible),
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
              onTap: () async{
                await context.read<AuthenticateProvider>().signOut();
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => IntroPage(),), (route) => false);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
