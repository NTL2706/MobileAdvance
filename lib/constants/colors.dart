import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  static const Color backgroundColor = Color(0xFFCE5A67);
  static const Color accentColor = Color.fromARGB(255, 164, 132, 132);
  static const Color primaryColor = Color.fromARGB(255, 244, 191, 150);
  static const Color textColor = Color.fromARGB(255, 31, 23, 23);
}

class Themes {
  static final ThemeData lightTheme = ThemeData(
    // useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Colors.blue,
  );

  static final ThemeData darkTheme = ThemeData(
    // useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: Colors.blueGrey,
  );

  static const Color backgroundLight = Colors.white;
  static const Color backgroundDark = Colors.blueGrey;

  static const Color textLight = Colors.black;
  static const Color textDark = Colors.white;
}
