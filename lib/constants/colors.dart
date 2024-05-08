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
    useMaterial3: true,
    brightness: Brightness.light,
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: Colors.black),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    highlightColor: Colors.white,
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: Colors.white),
    ),
  );

  static const Color backgroundLight = Colors.white;
  static const Color backgroundDark = Colors.black;

  static const Color selectColor = Colors.blue;

  static const Color textLight = Colors.black;
  static const Color textDark = Colors.white;

  static const Color boxLight = Colors.blue;
  static const Color boxDark = Colors.green;

  static const Color boxDecorationLight = Colors.grey;
  static const Color boxDecorationDark = Colors.white70;
}
