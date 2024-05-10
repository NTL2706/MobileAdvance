import 'package:final_project_advanced_mobile/languages/en.dart';
import 'package:final_project_advanced_mobile/languages/language.dart';
import 'package:final_project_advanced_mobile/languages/vi.dart';
import 'package:final_project_advanced_mobile/main.dart';
import 'package:flutter/widgets.dart';

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
        return LanguageVietNamese();
      default:
        return LanguageEn();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;
}

class LanguageService {
  static const String _key = 'language';
  final _box = sharedPreferences;

  void _saveLanguageToBox(String language) async {
    _box.setString(_key, language);
  }

  String _loadLanguageFromBox() {
    return _box.getString(_key) ?? 'vi';
  }

  Locale get language {
    return Locale(_loadLanguageFromBox(), '');
  }

  void switchLanguage(BuildContext context) {
    final newLanguage = _loadLanguageFromBox() == 'en' ? 'vi' : 'en';
    _saveLanguageToBox(newLanguage);
    MyApp.setLocale(context, Locale(newLanguage));
  }
}
