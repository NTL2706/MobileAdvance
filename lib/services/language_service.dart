import 'package:flutter/widgets.dart';

abstract class Languages {
  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  String get appName;

  String get welcomeText;

  String get appDescription;

  String get selectLanguage;
}

class LanguageEn extends Languages {
  @override
  String get appName => "Demo App";

  @override
  String get welcomeText => "Welcome";

  @override
  String get selectLanguage => "Select your language";

  @override
  String get appDescription =>
      "This application helps you to easily implement the multi language to your flutter application.";
}

class LanguageHi extends Languages {
  @override
  String get appName => "";

  @override
  String get welcomeText => "";

  @override
  String get selectLanguage => "";

  @override
  String get appDescription => "";
}

class AppLocalizationsDelegate extends LocalizationsDelegate<Languages> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'vi'].contains(locale.languageCode);

  @override
  Future<Languages> load(Locale locale) => _load(locale);

  static Future<Languages> _load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return LanguageEn();
      case 'vi':
        return LanguageHi();
      default:
        return LanguageEn();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;
}

// class LanguageService 
