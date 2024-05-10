import 'package:final_project_advanced_mobile/constants/colors.dart';
import 'package:final_project_advanced_mobile/feature/auth/provider/authenticate_provider.dart';
import 'package:final_project_advanced_mobile/feature/home/views/home_page.dart';
import 'package:final_project_advanced_mobile/feature/intro/views/intro_page.dart';
import 'package:final_project_advanced_mobile/feature/profie/models/profile.dart';
import 'package:final_project_advanced_mobile/feature/profie/provider/profile_provider.dart';
import 'package:final_project_advanced_mobile/feature/profie/views/change_pw_screen.dart';
import 'package:final_project_advanced_mobile/feature/profie/views/create_profile_page.dart';
import 'package:final_project_advanced_mobile/feature/profie/views/detail_profile_company_screen.dart';
import 'package:final_project_advanced_mobile/feature/profie/views/detail_profile_student_screen.dart';
import 'package:final_project_advanced_mobile/feature/profie/widgets/profile_list_title_widget.dart';
import 'package:final_project_advanced_mobile/languages/language.dart';
import 'package:final_project_advanced_mobile/services/language_service.dart';
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
  bool isLanguageListVisible = false;
  late AnimationController _controller;
  late Animation _animation;
  Profile? profile = null;
  final ProfileProvider profileProvider = ProfileProvider();

  @override
  void initState() {
    // TODO: implement initState
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
    _loadSkillsDefault();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();

    super.dispose();
  }

  void _loadSkillsDefault() async {
    await profileProvider.getProfileUser();
    setState(() {
      profile = profileProvider.profile;
    });
  }

  @override
  Widget build(BuildContext context) {
    String? role = context.read<AuthenticateProvider>().authenRepository.role;
    String? username =
        context.read<AuthenticateProvider>().authenRepository.username;
    Map<String, dynamic>? switchProfile;

    if (role == null || username == null) {
      Future.delayed(Duration(milliseconds: 200), () {
        context.read<AuthenticateProvider>().signOut(
            token:
                context.read<AuthenticateProvider>().authenRepository.token!);
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
          _appProfileAction(),
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
              Text(Languages.of(context)!.profile),
            ],
          ),
        ],
      ),
    );
  }

  Widget _switchAccountAction(bool isAccountListVisible) {
    String? role = context.read<AuthenticateProvider>().authenRepository.role;
    Map<String, dynamic>? switchProfile;
    String? username =
        context.read<AuthenticateProvider>().authenRepository.username;

    if (role == null || username == null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        builder: (context) {
          return IntroPage();
        },
      ), (route) => false);
    }
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
                          Text(username!),
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
                          ? Text(Languages.of(context)!.addCompany)
                          : Text(Languages.of(context)!.addStudent),
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

  Widget _switchLanguage(bool isLanguageListVisible) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: isLanguageListVisible ? 1.0 : 0.0,
      child: Visibility(
        visible: isLanguageListVisible,
        child: Container(
          padding: const EdgeInsets.only(left: 12.0),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.language),
                title: Text(Languages.of(context)!.changeLanguage),
                onTap: () {
                  // switch language
                  LanguageService().switchLanguage(context);
                },
              ),
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

  Widget _appProfileAction() {
    String? role = context.read<AuthenticateProvider>().authenRepository.role;
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
              title: Languages.of(context)!.switchAccount,
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
              title: Languages.of(context)!.profile,
              onTap: () {
                // move to profile screen
                if (role == "student") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // builder: (context) => const DetailProfileCompanyScreen(),
                      builder: (context) => DetailProfileStudentScreen(
                        profile: profile,
                      ),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // builder: (context) => const DetailProfileCompanyScreen(),
                      builder: (context) => DetailProfileCompanyScreen(
                        profile: profile,
                      ),
                    ),
                  );
                }
              },
            ),
            ProfileListTile(
              icon: Icons.account_circle,
              title: Languages.of(context)!.setting,
              onTap: () {
                setState(() {
                  isLanguageListVisible = !isLanguageListVisible;
                });
              },
            ),
            _switchLanguage(isLanguageListVisible),
            ProfileListTile(
              icon: Icons.password_outlined,
              title: Languages.of(context)!.changePassword,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    // builder: (context) => const DetailProfileCompanyScreen(),
                    builder: (context) =>
                        ChangePwScreen(apiForLogin: "/change-pw", title: "HUB"),
                  ),
                );
              },
            ),
            ProfileListTile(
              icon: Icons.logout,
              title: Languages.of(context)!.logout,
              onTap: () async {
                await context.read<AuthenticateProvider>().signOut(
                    token: context
                        .read<AuthenticateProvider>()
                        .authenRepository
                        .token!);
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
