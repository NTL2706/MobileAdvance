import 'package:final_project_advanced_mobile/configEnv.dart';
import 'package:final_project_advanced_mobile/feature/auth/provider/authenticate_provider.dart';
import 'package:final_project_advanced_mobile/feature/chat/provider/chat_provider.dart';
import 'package:final_project_advanced_mobile/feature/dashboard/providers/JobNotifier.dart';
import 'package:final_project_advanced_mobile/feature/home/views/home_page.dart';
import 'package:final_project_advanced_mobile/feature/intro/views/intro_page.dart';
import 'package:final_project_advanced_mobile/feature/profie/provider/profile_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './feature/projects/provider/project_provider.dart';
import 'package:flutter/material.dart';

late SharedPreferences sharedPreferences;
late configEnv env;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  sharedPreferences = await SharedPreferences.getInstance();
  env = configEnv();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
    AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
  //  await initializeService();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ProjectProvider()),
          ChangeNotifierProvider(create: (context) => JobNotifier()),
          ChangeNotifierProvider(
            create: (context) => ChatProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => AuthenticateProvider(),
          ),
          ChangeNotifierProvider(create: (context) => ProfileProvider())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          initialRoute: '/intro',
          routes: {
            '/intro': (context) => IntroPage(),
            '/home': (context) => HomePage(),
          },
          theme: ThemeData(
            // This is the theme of your application.
            //
            // TRY THIS: Try running your application with "flutter run". You'll see
            // the application has a purple toolbar. Then, without quitting the app,
            // try changing the seedColor in the colorScheme below to Colors.green
            // and then invoke "hot reload" (save your changes or press the "hot
            // reload" button in a Flutter-supported IDE, or press "r" if you used
            // the command line to start the app).
            //
            // Notice that the counter didn't reset back to zero; the application
            // state is not lost during the reload. To reset the state, use hot
            // restart instead.
            //
            // This works for code too, not just values: Most code changes can be
            // tested with just a hot reload.
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
        ));
  }
}
