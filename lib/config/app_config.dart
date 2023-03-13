import 'package:course_mania/locale/english.dart';
import 'package:course_mania/locale/german.dart';

class AppConfig {
  static const String appName = "CourseMania";
  static const bool isDemoMode = false;
  static const String languageDefault = "en";
  static final Map<String, AppLanguage> languagesSupported = {
    "en": AppLanguage("English", english()),
    "de": AppLanguage("Deutsch", german()),
  };
}

class AppLanguage {
  final String name;
  final Map<String, String> values;
  AppLanguage(this.name, this.values);
}
