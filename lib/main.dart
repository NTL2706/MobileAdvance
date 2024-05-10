import 'package:final_project_advanced_mobile/back_service.dart';
import 'package:final_project_advanced_mobile/configEnv.dart';
import 'package:final_project_advanced_mobile/constants/colors.dart';
import 'package:final_project_advanced_mobile/feature/auth/provider/authenticate_provider.dart';
import 'package:final_project_advanced_mobile/feature/chat/provider/chat_provider.dart';
import 'package:final_project_advanced_mobile/feature/dashboard/providers/JobNotifier.dart';
import 'package:final_project_advanced_mobile/feature/home/views/home_page.dart';
import 'package:final_project_advanced_mobile/feature/intro/views/intro_page.dart';
import 'package:final_project_advanced_mobile/feature/notification/provider/notify_provider.dart';
import 'package:final_project_advanced_mobile/feature/profie/provider/profile_provider.dart';
import 'package:final_project_advanced_mobile/services/language_service.dart';
import 'package:final_project_advanced_mobile/services/theme_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './feature/projects/provider/project_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

late SharedPreferences sharedPreferences;
late configEnv env;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  sharedPreferences = await SharedPreferences.getInstance();
  env = configEnv();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();
  await initializeService();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(newLocale);
  }

  static void restartApp(BuildContext context) {
    final _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
  }

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  Key key = UniqueKey();

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
    print('Set locale to ${_locale}');
  }

  @override
  void didChangeDependencies() {
    setState(() {
      _locale = LanguageService().language;
    });
    super.didChangeDependencies();
  }

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
          ChangeNotifierProvider(create: (context) => ProfileProvider()),
          ChangeNotifierProvider(create: (context) => NotiProvider()),
        ],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          initialRoute: '/intro',
          routes: {
            '/intro': (context) => IntroPage(),
            '/home': (context) => HomePage(),
          },
          supportedLocales: const [Locale('vi', ''), Locale('en', '')],
          localizationsDelegates: const [
            AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: _locale,
          localeResolutionCallback: (locale, supportedLocales) {
            _locale = LanguageService().language;
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == _locale?.languageCode &&
                  supportedLocale.countryCode == _locale?.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
            // if (_locale == Locale("vi", "")) {
            //   return locale;
            // } else {
            //   return Locale("en", "");
            // }
          },
          theme: Themes.lightTheme,
          darkTheme: Themes.darkTheme,
          themeMode: ThemeService().theme,
          // theme: ThemeData(
          //   // This is the theme of your application.
          //   //
          //   // TRY THIS: Try running your application with "flutter run". You'll see
          //   // the application has a purple toolbar. Then, without quitting the app,
          //   // try changing the seedColor in the colorScheme below to Colors.green
          //   // and then invoke "hot reload" (save your changes or press the "hot
          //   // reload" button in a Flutter-supported IDE, or press "r" if you used
          //   // the command line to start the app).
          //   //
          //   // Notice that the counter didn't reset back to zero; the application
          //   // state is not lost during the reload. To reset the state, use hot
          //   // restart instead.
          //   //
          //   // This works for code too, not just values: Most code changes can be
          //   // tested with just a hot reload.
          //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          //   useMaterial3: true,
          // ),
        ));
  }
}
